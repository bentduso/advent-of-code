defmodule AdventOfCode.Y2024.Day04 do
  alias AdventOfCode.{Input, Grid, Position}

  def part_1(input \\ Input.read_input!(2024, 4)) do
    input
    |> parse_input()
    |> count_occurrences()
  end

  def part_2(input \\ Input.read_input!(2024, 4)) do
    input
  end

  defp parse_input(input) do
    input
    |> Input.as_lines()
    |> Enum.map(&String.graphemes/1)
    |> Grid.new()
  end

  defp count_occurrences(grid) do
    for x <- 0..(grid.width - 1),
        y <- 0..(grid.height - 1) do
      case Grid.fetch(grid, Position.new(x, y)) do
        {:ok, "X"} -> count_in_directions(grid, Position.new(x, y))
        _ -> 0
      end
    end
    |> Enum.sum()
  end

  defp count_in_directions(grid, position) do
    Position.directions()
    |> Stream.map(&count_in_direction(grid, position, &1))
    |> Enum.sum()
  end

  defp count_in_direction(grid, position, direction) do
    word =
      0..3
      |> Stream.map(&apply(Position, :"move_#{direction}", [position, &1]))
      |> Stream.map(&Grid.at(grid, &1, "*"))
      |> Enum.join()

    if word == "XMAS", do: 1, else: 0
  end
end
