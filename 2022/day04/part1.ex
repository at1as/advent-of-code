# https://adventofcode.com/2022/day/4

defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim_trailing/1) 
  end
  
  defp range_is_contained([min1, max1, min2, max2]) when min1 >= min2 and max1 <= max2, do: 1
  defp range_is_contained([min1, max1, min2, max2]) when min2 >= min1 and max2 <= max1, do: 1
  defp range_is_contained([_min1, _max1, _min2, _max2]), 				do: 0

  defp range_partially_contained([min1, _max1, min2, max2]) when min1 >= min2 and min1 <= max2, do: 1
  defp range_partially_contained([min1, max1, min2, _max2]) when min2 >= min1 and min2 <= max1, do: 1
  defp range_partially_contained([_min1, _max1, _min2, _max2]), 		                do: 0

  def solve_pt1! do
    read_input("./input.txt")
    |> Enum.map(fn(x) -> Regex.split(~r/[-,]/, x) end)
    |> Enum.map(fn(x) -> Enum.map(x, &Integer.parse/1) end)
    |> Enum.map(&range_is_contained/1)
    |> Enum.sum
  end

  def solve_pt2! do
    read_input("./input.txt")
    |> Enum.map(fn(x) -> Regex.split(~r/[-,]/, x) end)
    |> Enum.map(fn(x) -> Enum.map(x, &Integer.parse/1) end)
    |> Enum.map(&range_partially_contained/1)
    |> Enum.sum
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1: #{Solution.solve_pt1!}"
# => 526

IO.puts "Part 2: #{Solution.solve_pt2!}"
# => 886

