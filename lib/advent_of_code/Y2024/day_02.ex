defmodule AdventOfCode.Y2024.Day02 do
  alias AdventOfCode.Input

  def part_1(input \\ Input.read_input!(2024, 2)) do
    input
    |> parse_input()
    |> Enum.count(&safe?/1)
  end

  def parse_input(input) do
    input
    |> Input.as_lines()
    |> Stream.map(fn line ->
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp safe?(list) when length(list) < 2, do: true

  defp safe?(list) do
    list
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.reduce_while(:unknown, &check_difference/2) != false
  end

  defguardp is_increasing(v1, v2) when v1 < v2 and abs(v1 - v2) <= 3

  defguardp is_decreasing(v1, v2) when v1 > v2 and abs(v1 - v2) <= 3

  defp check_difference([v1, v2], :unknown) when is_increasing(v1, v2), do: {:cont, :increasing}
  defp check_difference([v1, v2], :unknown) when is_decreasing(v1, v2), do: {:cont, :decreasing}

  defp check_difference([v1, v2], :increasing) when is_increasing(v1, v2) do
    {:cont, :increasing}
  end

  defp check_difference([v1, v2], :decreasing) when is_decreasing(v1, v2) do
    {:cont, :decreasing}
  end

  defp check_difference(_, _), do: {:halt, false}

  def part_2(input \\ Input.read_input!(2024, 2)) do
    input
    |> parse_input()
    |> Enum.count(&safe_with_removals?/1)
  end

  defp safe_with_removals?(list) do
    safe?(list) or
      Enum.any?(0..(length(list) - 1), fn index ->
        list
        |> List.delete_at(index)
        |> safe?()
      end)
  end
end
