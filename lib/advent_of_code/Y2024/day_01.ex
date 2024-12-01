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
    |> Enum.reduce({[], []}, fn line, {left_acc, right_acc} ->
      [left, right] = String.split(line, ~r{\s+})
      {[String.to_integer(left) | left_acc], [String.to_integer(right) | right_acc]}
    end)
  end

  defp calculate_total_distance({left, right}) do
    left
    |> Enum.sort()
    |> Enum.zip(Enum.sort(right))
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part_2(input \\ Input.read_input!(2024, 1)) do
    input
    |> parse_input()
    |> calculate_similarity_score()
  end

  defp calculate_similarity_score({left, right}) do
    Enum.reduce(left, 0, fn number, acc ->
      acc + number * Enum.count(right, &(&1 == number))
    end)
  end
end
