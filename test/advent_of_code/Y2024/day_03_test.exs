defmodule AdventOfCode.Y2024.Day03Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Y2024.Day03

  describe "part_1" do
    test "returns 161 for the Advent of Code example" do
      assert part_1("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))") ==
               161
    end

    test "returns 54 for valid mul instructions" do
      assert part_1("mul(2,4)mul(3,7)mul(5,5)") == 54
    end

    test "returns 36 for valid and invalid mul instructions" do
      assert part_1("mul(2,3)notmul(5,6)mul!(7,8)wrongml(4,5)") == 36
    end

    test "returns 0 for ivalid mul instructions" do
      assert part_1("xmul[2,4)%&[3,7]!@^do_not_mul(5,5]") == 0
    end
  end

  describe "part_2" do
    test "returns 48 for the Advent of Code example" do
      assert part_2("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))") ==
               48
    end

    test "returns 54 for valid mul instructions" do
      assert part_2("mul(2,4)mul(3,7)mul(5,5)") == 54
    end

    test "returns 33 for do() and don't() instructions" do
      assert part_2("mul(2,4)don't()mul(3,7)do()mul(5,5)") == 33
    end

    test "returns 0 with a don't() instruction at the start" do
      assert part_2("don't()mul(2,4)mul(3,7)") == 0
    end

    test "returns 29 with a do() instruction at the start" do
      assert part_2("do()mul(2,4)mul(3,7)") == 29
    end
  end
end
