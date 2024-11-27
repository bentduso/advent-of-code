defmodule Mix.Tasks.Aoc.Gen do
  @moduledoc """
  Generates the necessary solution, input and test files for an Advent of Code puzzle.

  This task requires the day of the puzzle as an argument.

      $ mix aoc.gen DAY [--year YEAR]

  ## Options

    * `--year` - specifies the year associated with the puzzle.

  ## Examples

      $ mix aoc.gen 20

  The above task, with 2024 set as the UTC year, is equivalent to:

      $ mix aoc.gen 20 --year 2024

  It would generate the following files:

  ```text
  lib/advent_of_code/Y2024/day_20.ex
  priv/inputs/Y2024/day20.txt
  test/advent_of_code/Y2024/day_20_test.exs
  ```
  """

  @shortdoc "Generates template files for an Advent of Code puzzle"

  use Mix.Task
  import Mix.Generator

  @requirements ["app.start"]
  @switches [year: :integer]
  @valid_days 1..25
  @aoc_start_year 2015
  @templates_path "priv/templates/aoc.gen"

  @impl true
  def run(argv) do
    case parse_args(argv) do
      {:ok, day, year} -> generate_puzzle_files(day, year)
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

  defp generate_puzzle_files(day, year) do
    day_padded = String.pad_leading(to_string(day), 2, "0")
    assigns = [day: day_padded, year: year]

    copy_template(
      Path.join(@templates_path, "solution.ex.eex"),
      solution_path(assigns),
      assigns
    )

    create_file(
      input_path(assigns),
      "# Paste your puzzle input here"
    )

    copy_template(
      Path.join(@templates_path, "test.exs.eex"),
      test_path(assigns),
      assigns
    )

    check_puzzle_availability(day, year)
  end

  defp solution_path(day: day, year: year), do: "lib/advent_of_code/Y#{year}/day_#{day}.ex"

  defp input_path(day: day, year: year), do: "priv/inputs/Y#{year}/day#{day}.txt"

  defp test_path(day: day, year: year), do: "test/advent_of_code/Y#{year}/day_#{day}_test.exs"

  defp check_puzzle_availability(day, year) do
    url = "https://adventofcode.com/#{year}/day/#{day}"

    case Req.get(url) do
      {:ok, resp} when resp.status == 404 ->
        Mix.Shell.IO.info([
          :light_yellow,
          "\nwarning: ",
          :reset,
          """
          the puzzle is currently unavailable, but it can be accessed at

              #{url}

          once the link is enabled.
          """
        ])

      {:ok, _} ->
        Mix.Shell.IO.info("\nAccess the puzzle at #{url}.")

      {:error, _} ->
        Mix.Shell.IO.error("\nCould not fetch puzzle availability.")
    end
  end
end
