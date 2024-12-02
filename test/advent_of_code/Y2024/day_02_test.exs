defmodule AdventOfCode.Y2024.Day02Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Y2024.Day02

  describe "part_1" do
    test "returns 2 for the Advent of Code example" do
      assert part_1("""
             7 6 4 2 1
             1 2 7 8 9
             9 7 6 2 1
             1 3 2 4 5
             8 6 4 4 1
             1 3 6 7 9
             """) == 2
    end

    test "returns 0 for reports with identical values" do
      assert part_1("""
             5 5 5 5 5
             9 9 9 9 9
             3 3 3 3 3
             2 2 2 2 2
             """) == 0
    end

    test "returns 0 for alternating value increases and decreases" do
      assert part_1("""
             1 5 3 8 2
             8 2 8 4 0
             9 2 5 0 4
             3 8 4 7 3
             """) == 0
    end
  end

  describe "part_2" do
    test "returns 4 for the Advent of Code example" do
      assert part_2("""
             7 6 4 2 1
             1 2 7 8 9
             9 7 6 2 1
             1 3 2 4 5
             8 6 4 4 1
             1 3 6 7 9
             """) == 4
    end

    test "returns 3 for reports that become safe after removal" do
      assert part_2("""
             6 5 3 3 1
             1 2 1 4 5
             5 8 9 2 6
             4 3 2 1 8
             7 9 4 6 2
             """) == 3
    end

    test "returns 0 for reports that are unsafe even after removal" do
      assert part_2("""
             9 2 6 1 2
             7 3 5 1 9
             8 2 4 3 7
             5 3 6 9 1
             4 2 7 8 5
             """) == 0
    end
  end
end
