# https://adventofcode.com/2021/day/3

defmodule Solution do

  def read_input(filepath) do 
    File.stream!(filepath)
      |> Stream.map(&String.trim_trailing/1)
      |> Stream.map(&String.split(&1, "", trim: true))
      |> Enum.to_list
  end

  def matrix_transpose(rows) do
    rows
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  def sum_rows(rows) do
    rows
      |> Enum.map(fn x -> x |> Enum.map(fn y -> if (y == "1"), do: 1, else: -1 end) end) 
      |> Enum.map(&Enum.sum(&1))
  end

  def rate(invert) do
    read_input("input.txt") 
      |> matrix_transpose 
      |> sum_rows 
      |> Enum.map(fn x -> case invert do
          false -> if (x < 0), do: 0, else: 1 
          true  -> if (x < 0), do: 1, else: 0 
        end
      end)
      |> Enum.join("")
      |> Integer.parse(2) 
      |> elem(0)
  end

  def gamma_rate do; rate(false); end

  def epsilon_rate do; rate(true); end

  def solve_pt1! do
    gamma_rate() * epsilon_rate()
  end

  def most_common(rows, index) do # n.b. inefficient!!
    rows
      |> matrix_transpose
      |> sum_rows
      |> Enum.map(fn x -> if (x >= 0), do: 1, else: 0 end)
      |> Enum.at(index)
  end

  def rating(rows, invert, offset) do
    common_bit     = most_common(rows, offset)
    target_indexes = rows 
                       |> matrix_transpose 
                       |> Enum.at(offset) 
                       |> Enum.with_index
                       |> Enum.filter(fn {y, _idx} -> 
                         case invert do
                           true  -> y != Integer.to_string(common_bit)
                           false -> y == Integer.to_string(common_bit) 
                         end 
                       end)
                       |> Enum.map(fn {_x, idx} -> idx end)

    filtered_rows  = rows
                       |> Enum.with_index
                       |> Enum.filter(fn {_x, idx} -> Enum.member?(target_indexes, idx) end) 
                       |> Enum.map(fn {x, _idx} -> x end)

    case length(filtered_rows) do
      1 -> filtered_rows
      0 -> filtered_rows
      _ -> rating(filtered_rows, invert, offset + 1)
    end
  end

  def output_to_decimal(output) do
    output 
      |> Enum.at(0)
      |> Enum.join("")
      |> Integer.parse(2)
      |> elem(0)
  end

  def oxygen_rating do
     read_input("input.txt") |> rating(false, 0) |> output_to_decimal()
  end

  def co2_rating do 
     read_input("input.txt") |> rating(true, 0) |> output_to_decimal()
  end

  def solve_pt2! do
    oxygen_rating() * co2_rating()
  end

end

IO.puts "Part 1: #{Solution.solve_pt1!}"
# => 2640986

IO.puts "Part 2: #{Solution.solve_pt2!}"
# => 6822109

