defmodule Day2Test do
  use ExUnit.Case
  doctest Day2


  # analyze()
  test "returns depth and forward changes in position" do
    data = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

    assert Day2.analyze(data, 0, 0) == %{ :forward => 15, :depth => 10 }
  end
end
