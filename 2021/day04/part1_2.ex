defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
      |> Stream.map(&String.trim_trailing/1) 
      |> Enum.filter(& &1 != "")
  end

  defp matrix_transpose(board) do
    board 
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  defp solved_row?(row) do
    Enum.all?(row, & &1 == "*")
  end

  defp has_bingo(board) do
    Enum.any?(board, & solved_row?(&1)) || (board |> matrix_transpose |> Enum.any?(& solved_row?(&1)))
  end

  defp board_value(board) do
    board 
      |> List.flatten
      |> Enum.reduce(0, fn(x, acc) -> if (x != "*"), do: String.to_integer(x) + acc, else: acc end)
  end

  defp play(draw_nums, rows, game_type) do
    draw_num  = hd(draw_nums) # n.b. not safe in the case nobody has bingo before draw nums run out
    next_nums = tl(draw_nums)
    next_rows = rows
                 |> Enum.map(& Enum.map(&1, fn(y) -> if (y == draw_num), do: "*", else: y end))

    winners = next_rows 
               |> Enum.chunk_every(5)
               |> Enum.filter(& has_bingo(&1))
    losers  = next_rows
               |> Enum.chunk_every(5)
               |> Enum.filter(& !has_bingo(&1))

    case game_type do
      :to_lose -> case length(losers) do
                    0 -> String.to_integer(draw_num) * (next_rows |> board_value) # no instructions provided, but for now if remaining players all lose at once, tally of all boards will be included
                    _ -> play(next_nums, List.foldl(losers, [], &(&1 ++ &2)), game_type)
                  end
      _        -> case length(winners) do
                    0 -> play(next_nums, next_rows, game_type)
                    _ -> String.to_integer(draw_num) * (winners 
                                                   |> Enum.at(0) # no instructions given on if there are multiple winners, so just select one (for now)
                                                   |> board_value)
                  end
    end
  end

  defp setup_game(game_type) do
    input     = read_input("./input.txt")
    draw_nums = input 
                  |> Enum.at(0) 
                  |> String.split(",", trim: true)
    rows      = input 
                  |> Enum.drop(1)
                  |> Enum.map(&String.split(&1, " ", trim: true))

    play(draw_nums, rows, game_type)
  end

  def solve_pt1! do
    setup_game(:to_win)
  end

  def solve_pt2! do
    setup_game(:to_lose)
  end

end

IO.puts Solution.solve_pt1!()
# => 69579

IO.puts Solution.solve_pt2!()
# => 14877

