# https://adventofcode.com/2022/day/1

defmodule Solution do

  def read_input(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim_trailing/1) 
  end

  def cluster_sums(num_items) do
    read_input("./input.txt")
    |> Enum.join("\n")
    |> String.split("\n\n") 
    |> Enum.map(fn(n) -> n 
	|> String.split("\n", trim: true) 
	|> Enum.map(&String.to_integer(&1)) 
	|> Enum.sum 
    end)
    |> Enum.sort
    |> Enum.take(num_items * -1)
    |> Enum.sum
  end

  def solve_pt1! do
    cluster_sums(1)
  end

  def solve_pt2! do
    cluster_sums(3)
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1 #{Solution.solve_pt1!}"
# => 72602

IO.puts "Part 2 #{Solution.solve_pt2!}"
# => 207410

