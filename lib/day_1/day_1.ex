defmodule Day1 do
  @moduledoc """
  Solution to Day 1 Advent of Code puzzle 2021: SonarSweep
  """

  @doc """
  Returns the number of instances a measurement increased from the
  previous measurement
  """
  def run(filepath) do
    data = get_data(filepath)
    sweep(data, 0)
  end

  @doc """
  Reads measurement data from a .txt file and converts it into a List
  of Integer

  Returns a list of numbers given a filename -  the expected format
  is a return-separated list of numerical values.
  """
  def get_data(filepath) do
    {:ok, data} = File.read(filepath)
    string_data = data |> String.split("\n", trim: true)
    Day1.bins_to_ints(string_data, [])
  end

  @doc """
  Converts a list of bitstrings to a list of Integers

  Returns a list of Integers
  """
  def bins_to_ints(string_list, int_list) do
    Enum.reverse(Enum.reduce(string_list, int_list, fn(x, acc) -> [elem(Integer.parse(x, 10), 0) | acc] end))
  end

  @doc """
  Analyzes measurement data to determine speed of depth increases

  Returns number of times a measurement in the input data increased
  from the previous measurement
  """
  def sweep(list, increases) do
    cond do
      length(list) === 1 ->
        increases
      Enum.at(list, 0) < Enum.at(list, 1) ->
        sweep(Enum.slice(list, 1..length(list) - 1), (increases + 1))
      Enum.at(list, 0) > Enum.at(list, 1) ->
        sweep(Enum.slice(list, 1..length(list) - 1), increases)
    end
  end
end
