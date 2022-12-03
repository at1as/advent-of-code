# https://adventofcode.com/2022/day/3

defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim_trailing/1) 
  end

  defp item_priority(item) do
    Map.new(Enum.zip(
       Enum.map(?a..?z, fn(x) -> <<x :: utf8>> end) ++ Enum.map(?A..?Z, fn(x) -> <<x :: utf8>> end),
       (1..52)
    ))[item]
  end

  defp separate_items(items) do
    items
    |> String.codepoints
    |> Enum.chunk_every(length(String.codepoints(items))/2 |> round)
    |> Enum.map(&Enum.join/1)
  end

  defp find_common([]), 	   do: []
  defp find_common([l1]), 	   do: [l1]
  defp find_common([l1, l2]),      do: l1 -- (l1 -- l2)
  defp find_common([head | tail]), do: find_common([head, find_common(tail)])

  def solve_pt1! do
    read_input("./input.txt")
    |> Enum.map(fn(x) -> String.split(x) |> Enum.map(&separate_items/1) end)
    |> Enum.map(fn([[l1, l2]]) -> find_common([String.codepoints(l1), String.codepoints(l2)]) end)
    |> Enum.map(fn(y) -> Enum.map(Enum.take(y, 1), &item_priority/1) |> Enum.sum end) 
    |> Enum.sum
  end

  def solve_pt2! do
    read_input("./input.txt")
    |> Enum.map(&String.split/1)
    |> Enum.chunk_every(3)
    |> Enum.map(fn([[l1], [l2], [l3]]) -> find_common([String.codepoints(l1), String.codepoints(l2), String.codepoints(l3)]) end)
    |> Enum.map(fn(y) -> Enum.map(y |> Enum.take(1), &item_priority/1) |> Enum.sum end) 
    |> Enum.sum
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1 #{Solution.solve_pt1!}"
# => 7763

IO.puts "Part 2 #{Solution.solve_pt2!}"
# => 2569

