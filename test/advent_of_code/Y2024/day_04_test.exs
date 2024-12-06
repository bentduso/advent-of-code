defmodule AdventOfCode.Y2024.Day04Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Y2024.Day04

  describe "part_1" do
    test "returns 18 for the Advent of Code example" do
      assert part_1("""
             MMMSXXMASM
             MSAMXMSMSA
             AMXSXMAAMM
             MSAMASMSMX
             XMASAMXAMM
             XXAMMXXAMA
             SMSMSASXSS
             SAXAMASAAA
             MAMMMXMMMM
             MXMXAXMASX
             """) == 18
    end
  end
end
