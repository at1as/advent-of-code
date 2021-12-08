defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
      |> Stream.map(&String.trim_trailing/1) 
      |> Stream.map(&String.split(&1, ",", trim: true))
      |> Enum.to_list
      |> List.flatten
      |> Stream.map(&String.to_integer(&1))
  end

  # solution that did not scale
  def spawnfish_slow(state, iters) do
    IO.inspect "#{iters}"
    cond do
      iters >= 1 -> Enum.reduce(state, [], fn (x, acc) -> if (x == 0), do: [8] ++ [6] ++ acc, else: [x-1] ++ acc end) |> spawnfish_slow(iters - 1)
      true       -> length(state)
    end
  end

 # scalable solution
 def spawnfish(map, iters) do
   cond do
     iters >= 1 -> Map.keys(map)
                     |> Enum.reduce(%{}, (fn (x, acc) -> case x do
                       0 -> Map.merge(acc, %{6 => Map.get(map, 0, 0), 8 => Map.get(map, 0, 0)}, fn (_k, v1, v2) -> v1 + v2 end)
                       _ -> Map.merge(acc, %{(x-1) => Map.get(map, x, 0)}, fn (_k, v1, v2) -> v1 + v2 end)
                     end end))
                     |> spawnfish(iters - 1)
     true       -> Map.values(map)
                     |> Enum.sum
   end
 end

  def solver(iters) do
    read_input("./input.txt") 
      |> Enum.reduce(%{}, fn (x, acc) -> Map.update(acc, x, 1, fn y -> y + 1 end) end)
      |> spawnfish(iters)
  end

  def solve_pt1! do
    solver(80)
  end

  def solve_pt2! do
    solver(256)
  end
end

IO.puts "Part 1: #{Solution.solve_pt1!()}"
IO.puts "Part 2: #{Solution.solve_pt2!()}"

