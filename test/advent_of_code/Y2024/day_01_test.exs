defmodule AdventOfCode.Y2024.Day01Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Y2024.Day01

  describe "part_1" do
    test "returns a total distance of 11 for the Advent of Code example" do
      assert part_1("3   4\n4   3\n2   5\n1   3\n3   9\n3   3") == 11
    end

    test "returns a total distance for nonoverlapping ranges" do
      assert part_1("17113   23229\n55260   78804\n92726   24891") == 50407
    end
  end

  describe "part_2" do
    test "returns a similarity score of 31 for the Advent of Code example" do
      assert part_2("3   4\n4   3\n2   5\n1   3\n3   9\n3   3") == 31
    end

    test "returns a similarity score of 0 for nonoverlapping ranges" do
      assert part_2("17113   23229\n55260   78804\n92726   24891") == 0
    end
  end
end
