defmodule AdventOfCode.Y2024.Day03 do
  alias AdventOfCode.Input

  def part_1(input \\ Input.read_input!(2024, 3)) do
    ~r{mul\((\d+),(\d+)\)}
    |> Regex.scan(input)
    |> Stream.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end

  def part_2(input \\ Input.read_input!(2024, 3)) do
    ~r{do\(\)|don't\(\)|mul\((\d+),(\d+)\)}
    |> Regex.scan(input)
    |> Enum.reduce({0, true}, fn
      ["don't()"], {sum, _} -> {sum, false}
      ["do()"], {sum, _} -> {sum, true}
      [_, a, b], {sum, true} -> {sum + String.to_integer(a) * String.to_integer(b), true}
      _, sum -> sum
    end)
    |> elem(0)
  end
end
