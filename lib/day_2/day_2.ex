defmodule Day2 do
  @moduledoc """
  Solution to Day 2 Advent of Code puzzle 2021: Dive!

  Assumptions: All values for command distance are < 10 units
  """

  # sort inputs into 2 lists to reduce, x & y
  # up/down (up: negative, down: positive)
  # - seems like all commands are < 10

  # 2 ways to skin this cat -
  #   1) take in all the data, forward[], up/down[] where up is negative
  #      (reducing depth) and down is positive (increasing depth) and store
  #       in 2 arrays, then reduce them
  #     - useful if you need to access vert/horizontal data changes individually

  #   2) process input at the same time as it is parsed

  @spec run(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: :ok
  @doc """
  Returns the number of instances a measurement increased from the
  previous measurement
  """
  def run(filepath) do
    data = get_data(filepath)
    output = analyze(data, 0, 0)
    IO.puts("Change in horizontal position: #{output.forward}")
    IO.puts("Change in vertical position: #{output.depth}")

    IO.puts("------------ Calculations with aim ------------")
    output = analyze_aim(data, 0, 0, 0)
    IO.puts("Change in horizontal position: #{output.forward}")
    IO.puts("Change in vertical position: #{output.depth}")
  end

  @doc """
  Reads measurement data from a .txt file and converts it into a List
  of Integer

  Returns a list of numbers given a filename -  the expected format
  is a return-separated list of numerical values.
  """
  def get_data(filepath) do
    {:ok, data} = File.read(filepath)
    data |> String.split("\n", trim: true)
    |> parse_data()
  end

  def parse_data(list) do
    Enum.reverse(Enum.reduce(list, [], fn(x, acc) -> [Day2.parse_datum(x) | acc] end))
  end

  def parse_datum(bitstring) do
    l = length(to_charlist(bitstring))
    %{ :direction => String.first(bitstring), :magnitude => elem(Integer.parse(String.slice(bitstring, l-1..l), 10), 0) }
  end

  @doc """
  Converts a list of bitstrings to a list of Integers

  Returns a list of Integers
  """
  def bins_to_ints(string_list, int_list) do
    Enum.reverse(Enum.reduce(string_list, int_list, fn(x, acc) -> [elem(Integer.parse(x, 10), 0) | acc] end))
  end

  @doc """
  Analyzes measurement data to determine vertical & horizontal depth changes

  Returns change in direction and magnitude of that change
  """
  def analyze(list, depth, forward) do
    current = Enum.at(list, 0)

    cond do
      !current ->
        %{ :depth => depth, :forward => forward }
      current.direction === "f" ->
        # get the numerical value of horizontal movement
        analyze(Enum.slice(list, 1..length(list) - 1), depth, forward + current.magnitude)
      current.direction === "d" ->
        analyze(Enum.slice(list, 1..length(list) - 1), depth + current.magnitude, forward)
      current.direction === "u" ->
        analyze(Enum.slice(list, 1..length(list) - 1), depth - current.magnitude, forward)
    end
  end

  def analyze_aim(list, depth, forward, aim) do
    current = Enum.at(list, 0)

    cond do
      !current ->
        %{ :depth => depth, :forward => forward }
      current.direction === "d" ->
        analyze_aim(Enum.slice(list, 1..length(list) - 1), depth, forward, aim + current.magnitude)
      current.direction === "u" ->
        analyze_aim(Enum.slice(list, 1..length(list) - 1), depth, forward, aim - current.magnitude)
      current.direction === "f" ->
        analyze_aim(Enum.slice(list, 1..length(list) - 1), depth + aim * current.magnitude, forward + current.magnitude, aim)
    end
  end
end
