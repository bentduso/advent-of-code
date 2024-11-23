defmodule Mix.Tasks.Aoc.Gen do
  @moduledoc """
  Generates the necessary solution and test files for an Advent of Code challenge.

  This task requires the day of the challenge as an argument.

      $ mix aoc.gen DAY [--year YEAR]

  ## Options

    * `--year` - specifies the year associated with the challenge.

  ## Examples

      $ mix aoc.gen 20

  The above task, with 2024 set as the UTC year, is equivalent to:

      $ mix aoc.gen 20 --year 2024

  It would generate the following modules:

  ```text
  lib/advent_of_code/Y2024/day_20.ex
  test/advent_of_code/Y2024/day_20_test.exs
  ```
  """

  @shortdoc "Generates template files for an Advent of Code challenge"

  use Mix.Task

  @switches [year: :integer]
  @valid_days 1..25
  @aoc_start_year 2015

  @templates_path "priv/templates/aoc.gen"

  @impl true
  def run(argv) do
    case parse_args(argv) do
      {:ok, day, year} -> generate_challenge_files(day, year)
      {:error, message} -> Mix.raise(message)
    end
  end

  defp parse_args(argv) do
    case OptionParser.parse(argv, strict: @switches) do
      {parsed, [day], []} ->
        validate_day_and_year(day, parsed[:year] || DateTime.utc_now().year)

      {[], [], []} ->
        {:error,
         ~s(Expected DAY to be given. Please use "mix aoc.gen DAY" or specify a year with the "--year YEAR" option)}

      {_, _, [{"--year", _}]} ->
        {:error, "The year must be a valid integer"}

      {_, _, [{option, nil}]} ->
        {:error, ~s(Unknown option "#{option}". Did you mean "--year"?)}

      {_, args, _} when length(args) > 1 ->
        {:error,
         ~s(Too many arguments. Please use "mix aoc.gen DAY" or specify a year with the "--year YEAR" option)}
    end
  end

  defp validate_day_and_year(day, year) do
    with {:ok, day_int} <- validate_day(day),
         :ok <- validate_year(year) do
      {:ok, day_int, year}
    end
  end

  defp validate_day(day) do
    case Integer.parse(day) do
      {day_int, ""} when day_int in @valid_days ->
        {:ok, day_int}

      {_day_int, ""} ->
        {:error, "The day must be a valid integer between 1 and 25"}

      :error ->
        {:error, "The day must be a valid integer"}
    end
  end

  defp validate_year(year) when is_integer(year) and year >= @aoc_start_year, do: :ok

  defp validate_year(year) when is_integer(year) do
    {:error, "The year must be at least #{@aoc_start_year}, when Advent of Code began"}
  end

  defp generate_challenge_files(day, year) do
    day_padded = String.pad_leading(to_string(day), 2, "0")
    assigns = %{year: year, day: day_padded}

    assigns
    |> files_to_generate()
    |> Enum.each(&create_file/1)
  end

  defp files_to_generate(assigns) do
    [
      {solution_path(assigns), eval_template("solution.ex.eex", assigns)},
      {test_path(assigns), eval_template("test.exs.eex", assigns)}
    ]
  end

  defp solution_path(%{year: year, day: day}), do: "lib/advent_of_code/Y#{year}/day_#{day}.ex"
  defp test_path(%{year: year, day: day}), do: "test/advent_of_code/Y#{year}/day_#{day}_test.exs"

  defp eval_template(template_name, assigns) do
    Application.get_application(__MODULE__)
    |> Application.app_dir(@templates_path)
    |> Path.join(template_name)
    |> EEx.eval_file(assigns: assigns)
  end

  defp create_file({path, content}) do
    File.mkdir_p!(Path.dirname(path))

    case File.write(path, content) do
      :ok ->
        Mix.shell().info([:green, "* created ", :reset, path])

      {:error, reason} ->
        Mix.raise("Failed to create file #{path}: #{:file.format_error(reason)}")
    end
  end
end
