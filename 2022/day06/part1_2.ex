# https://adventofcode.com/2022/day/6

defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim_trailing/1) 
  end

  def generic_solver(chunksize) do
    read_input("./input.txt")
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&Enum.chunk_every(&1, chunksize, 1))
    |> Enum.at(0)
    |> Enum.with_index(fn(list, indx) -> {indx, list} end)
    |> Enum.filter(fn({_idx, list}) -> length(list) == length(Enum.uniq(list)) end)
    |> Enum.take(1)   
    |> Enum.map(fn({idx, _list}) -> "#{idx + chunksize}" end)
  end
  
  def solve_pt1! do
    generic_solver(4)
  end

  def solve_pt2! do
    generic_solver(14)
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1: #{Solution.solve_pt1!}"
# => 1093

IO.puts "Part 2: #{Solution.solve_pt2!}"
# => 3534

