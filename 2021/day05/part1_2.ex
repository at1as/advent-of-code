# https://adventofcode.com/2021/day/5#

defmodule Solution do

  def read_input(filepath) do
    File.stream!(filepath)
      |> Stream.map(&String.trim_trailing/1) 
      |> Enum.filter(& &1 != "")
  end

  def horizontal_vertical_lines(coords) do
    Enum.map(coords, &String.split(&1, " -> ", trim: true))
      |> Enum.map(fn [x, y] -> String.split(x <> "," <> y, ",", trim: true) end)
      |> Enum.filter(fn [x1,y1,x2,y2] -> x1 == x2 || y1 == y2 end)
      |> Enum.map(fn x -> x |> Enum.map(& String.to_integer(&1)) end)
  end

  def all_lines(coords) do
    Enum.map(coords, &String.split(&1, " -> ", trim: true))
      |> Enum.map(fn [x, y] -> String.split(x <> "," <> y, ",", trim: true) end)
      |> Enum.map(fn x -> x |> Enum.map(& String.to_integer(&1)) end)
  end

  def traverse_all(x1, y1, x2, y2) do
    cond do
      (x1 == x2) -> 
        x_axis = [x1]
        y_axis = Enum.to_list(Enum.min([y1, y2])..Enum.max([y1, y2]))
        Enum.zip(Stream.cycle(x_axis), y_axis)
      (y1 == y2) -> 
        x_axis = Enum.to_list(Enum.min([x1, x2])..Enum.max([x1, x2]))
        y_axis = [y1]
        Enum.zip(x_axis, Stream.cycle(y_axis))
      true -> # because we know that diagonals are only at 45 degrees, this should work
        x_axis = Enum.to_list(x1..x2)
        y_axis = Enum.to_list(y1..y2)
        Enum.zip(x_axis, y_axis)
    end
  end

  def count_duplicates(lines) do
    lines
      |> Enum.map(fn [x1, x2, y1, y2] -> traverse_all(x1, x2, y1, y2) end)
      |> List.flatten
      |> Enum.reduce(%{}, fn (x, acc) -> Map.update(acc, x, 1, &(&1 + 1)) end)
      |> Map.to_list
      |> Enum.filter(fn {{_x, _y}, c} -> c > 1 end)
  end

  def solve_pt1! do
    read_input("./input.txt") 
      |> horizontal_vertical_lines
      |> count_duplicates
      |> length
  end

  def solve_pt2! do
    read_input("./input.txt") 
      |> all_lines
      |> count_duplicates
      |> length
  end
end

IO.puts "Part 1: #{Solution.solve_pt1!}"
# => 5197

IO.puts "Part 2: #{Solution.solve_pt2!}"
# => 18605

