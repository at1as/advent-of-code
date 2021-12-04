# https://adventofcode.com/2021/day/2

defmodule Solution do
  
  def read_input(filepath) do
    File.stream!(filepath) 
      |> Stream.map(&String.trim_trailing/1)
      |> Stream.map(&String.split(&1, " "))
      |> Stream.map(fn [x, y] -> [x, String.to_integer(y)] end)
  end
  
  def solve_pt1! do
    read_input("input.txt")
      |> Enum.reduce([0, 0], fn [dir, mag], [acc_x, acc_y] -> case [dir, mag] do 
            ["forward", x] -> [ acc_x + x , acc_y     ] 
            ["down",    y] -> [ acc_x     , acc_y + y ] 
            ["up",      y] -> [ acc_x     , acc_y - y ] 
            [_x,       _y] -> [ acc_x     , acc_y     ] 
          end
        end) 
      |> Enum.reduce(1, fn(x, acc) -> x * acc end)
  end

  def solve_pt2! do 
    read_input("input.txt")
      |> Enum.reduce([0, 0, 0], fn [dir, mag], [acc_x, acc_y, acc_aim] -> case [dir, mag] do 
            ["forward", x] -> [ acc_x + x , acc_y + (acc_aim * x) , acc_aim     ] 
            ["down",    z] -> [ acc_x     , acc_y                 , acc_aim + z ] 
            ["up",      z] -> [ acc_x     , acc_y                 , acc_aim - z ] 
            [_x,       _y] -> [ acc_x     , acc_y                 , acc_aim     ]
          end
        end)
      |> Enum.take(2)
      |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

end

# ❯ elixir -r part1_2.ex -e 'Solution'

IO.puts Solution.solve_pt1!
# => 2147104

IO.puts Solution.solve_pt2!
# => 2044620088

