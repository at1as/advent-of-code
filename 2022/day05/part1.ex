# https://adventofcode.com/2022/day/4

defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim_trailing/1) 
  end

  defp extract_instructions(full_input) do
    full_input
    |> Enum.filter(&String.starts_with?(&1, "move"))
    |> Enum.map(&Regex.run(~r/move ([\d]+) from ([\d]+) to ([\d])/, &1))
  end 

  defp empty_element(), do: ["    "]

  defp extract_stack(full_input) do
    full_input
    |> Enum.filter(&String.starts_with?(&1, "["))
    |> Enum.map(fn(x) -> x <> " " end) # add one cell of padding so every cell is 4 spaces
    |> Enum.map(&Regex.scan(~r/.{4}/, &1))
  end

  defp equalize_stack(stacks) do
    max_size = stacks |> Enum.map(&length/1) |> Enum.max
    stacks |> Enum.map(fn(row) -> 
      if length(row) == max_size do
        row
      else
        Enum.reduce(Enum.to_list(1..(max_size - length(row))), row, fn(_i, acc) -> acc ++ [empty_element()] end)
      end
    end)
  end 

  defp array_replace(array, row_idx, col_idx, value) do
    List.replace_at(
      array,
      row_idx,
      List.replace_at(Enum.at(array, row_idx), col_idx, value)
    )
  end

  defp safe_swap(array, source_row_idx, source_col_idx, target_row_idx, target_col_idx, source_val) do
    if target_row_idx == 0 do
      blank_row = array |> Enum.take(1) |> Enum.map(fn(x) -> Enum.map(x, fn(_y) -> empty_element() end) end)

      blank_row ++ array
      |> array_replace(source_row_idx + 1, source_col_idx, empty_element())
      |> array_replace(0,                  target_col_idx, source_val)
    else
      row_idx = if target_row_idx == nil, do: length(array) - 1, else: target_row_idx - 1

      array
      |> array_replace(source_row_idx,  source_col_idx, empty_element())
      |> array_replace(row_idx,         target_col_idx, source_val)
    end
  end

  def generic_solver(move_simultaneously) do
    read_input("./input.txt")
    |> extract_instructions
    |> Enum.map(fn([_instruction, quantity, from_stack, to_stack]) -> [String.to_integer(quantity), String.to_integer(from_stack), String.to_integer(to_stack)] end)
    |> Enum.reduce(read_input("./input.txt") |> extract_stack |> equalize_stack, fn ([quantity, from_stack_idx, to_stack_idx], acc) -> 
	Enum.reduce(Enum.to_list(1..quantity), acc, fn(offset, acc) ->

          # Co-ords (destination)
          target_col_idx = to_stack_idx - 1 # to_stack_idx is not 0-indexed
          target_row_idx = acc 
	  |> Enum.with_index(fn element, index -> {index, element} end)
          |> Enum.filter(fn({_idx, row}) -> Enum.at(row, target_col_idx) != empty_element() end)
          |> Enum.map(fn({idx, _row}) -> idx end)
          |> Enum.at(0)

          # Co-ords (source)
          source_col_idx = from_stack_idx - 1 # from_stack_idx is not 0-indexed
          source_row_idx = acc
	  |> Enum.with_index(fn element, index -> {index, element} end)
          |> Enum.filter(fn({_idx, row}) -> Enum.at(row, source_col_idx) != empty_element() end)
          |> Enum.map(fn({idx, _row}) -> idx end)
          |> Enum.at(0)

          shifted_source_row_idx = if move_simultaneously, do: source_row_idx + (quantity - offset), else: source_row_idx

          source_val = acc |> Enum.at(shifted_source_row_idx) |> Enum.at(source_col_idx)
          
          safe_swap(acc, shifted_source_row_idx, source_col_idx, target_row_idx, target_col_idx, source_val)
 
        end)
    end) 
    |> Enum.with_index(fn(row, idx) -> IO.puts("<ROW#{idx}> #{row} </ROW#{idx}>") end)
  end

  def solve_pt1! do
    generic_solver(false)
  end

  def solve_pt2! do
    generic_solver(true)
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1:"
Solution.solve_pt1!
# => QNNTGTPFN

IO.puts "Part 2:"
Solution.solve_pt2!
# => GGNPJBTTR

