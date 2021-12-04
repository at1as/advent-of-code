# https://adventofcode.com/2021/day/1

defmodule Solution do

  def read_input(filepath) do
    File.stream!(filepath)
      |> Stream.map(&String.trim_trailing/1) 
      |> Enum.map(&String.to_integer(&1))
  end

  def solve_pt1! do
    read_input("./input.txt")
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [x, y] -> if (y > x), do: 1, else: 0 ; end)
      |> Enum.sum
  end

  def solve_pt2! do
    read_input("./input.txt") 
      |> Enum.chunk_every(3, 1, :discard) 
      |> Enum.map(&Enum.sum/1)
      |> Enum.chunk_every(2, 1, :discard) 
      |> Enum.map(fn [x, y] -> if (y > x), do: 1, else: 0 ; end) 
      |> Enum.sum
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1 #{Solution.solve_pt1!}"
# => 1715

IO.puts "Part 2 #{Solution.solve_pt2!}"
# => 1739

