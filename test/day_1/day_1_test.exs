defmodule Day1Test do
  use ExUnit.Case
  doctest Day1


   # bins_to_ints()
   test "converts set of bitstrings to ints" do
    assert Day1.bins_to_ints(["0", "1", "2", "3"], []) == [0, 1, 2, 3]
  end

  # sweep()
  test "returns correct number of increases from prev value in data set" do
    data_set = [1, 2, 3]
    expected_result = 2
    assert Day1.sweep(data_set, 0) == expected_result
  end

  test "returns correct increases in varied data set" do
    data_set = ["1", "2", "0", "3", "0"]
    expected_result = 2
    assert Day1.sweep(data_set, 0) == expected_result
  end

  test "returns correct increases in set with no increases" do
    data_set = ["5", "4", "3", "2", "1"]
    expected_result = 0
    assert Day1.sweep(data_set, 0) == expected_result
  end

  # normalize_data()
  test "returns number of normalized measurement increases" do
    data_set = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert Day1.normalize_data(data_set, 0) == 5
  end
end
