defmodule AdventOfCode.Y2024.Day01 do
  alias AdventOfCode.Input

  def part_1(input \\ Input.read_input!(2024, 1)) do
    input
    |> parse_input()
    |> calculate_total_distance()
  end

  defp parse_input(input) do
    input
    |> Input.as_lines()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split(~r{\s+})
    |> Enum.map(&String.to_integer/1)
  end

  defp calculate_total_distance(lines) do
    left_sorted =
      lines
      |> Enum.map(&Enum.at(&1, 0))
      |> Enum.sort()

    right_sorted =
      lines
      |> Enum.map(&Enum.at(&1, 1))
      |> Enum.sort()

    Enum.zip(left_sorted, right_sorted)
    |> Enum.map(fn {left, right} -> abs(left - right) end)
    |> Enum.sum()
  end

  def part_2(input \\ Input.read_input!(2024, 1)) do
    input
    |> parse_input()
    |> calculate_similarity_score()
  end

  defp calculate_similarity_score(lines) do
    right_frequencies =
      lines
      |> Enum.map(&Enum.at(&1, 1))
      |> Enum.frequencies()

    left_values = Enum.map(lines, &Enum.at(&1, 0))

    Enum.reduce(left_values, 0, fn number, acc ->
      acc + number * Map.get(right_frequencies, number, 0)
    end)
  end
end
