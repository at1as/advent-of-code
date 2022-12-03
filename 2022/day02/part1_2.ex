# https://adventofcode.com/2022/day/2

defmodule Solution do

  defp read_input(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim_trailing/1) 
  end

  defp handmapper(hand) when hand in ["X", "A"], do: :rock
  defp handmapper(hand) when hand in ["Y", "B"], do: :paper
  defp handmapper(hand) when hand in ["Z", "C"], do: :scissors

  defp handpoints(:rock),     do: 1
  defp handpoints(:paper),    do: 2
  defp handpoints(:scissors), do: 3

  defp winnerpoints(), do: 6
  defp tiepoints(),    do: 3
  defp loserpoints(),  do: 0

  defp winner(opponent_choice, choice) when opponent_choice == choice, do: tiepoints() + handpoints(choice)
  defp winner(opponent_choice, choice) do
    cond do
      winning_hand(opponent_choice) == choice -> winnerpoints() + handpoints(choice)
      true            		              -> loserpoints()  + handpoints(choice)
    end
  end

  def tournament_sum do
    read_input("./input.txt")
    |> Enum.map(fn(x) -> String.split(x) |> Enum.map(fn(hand) -> handmapper(hand) end) end)
    |> Enum.map(fn([opponent_choice, choice]) -> winner(opponent_choice, choice) end)
    |> Enum.sum
  end

  def solve_pt1! do
    tournament_sum() 
  end

  defp winning_hand(:rock),     do: :paper
  defp winning_hand(:paper),    do: :scissors
  defp winning_hand(:scissors), do: :rock

  defp result_mapper("X"), do: :lose
  defp result_mapper("Y"), do: :draw
  defp result_mapper("Z"), do: :win

  defp cheat(opponent_hand, result) when result == :win,  do: winnerpoints() + handpoints(winning_hand(opponent_hand))
  defp cheat(opponent_hand, result) when result == :draw, do: tiepoints()    + handpoints(opponent_hand)
  defp cheat(opponent_hand, result) when result == :lose, do: loserpoints()  + handpoints(winning_hand(winning_hand(opponent_hand)))

  def solve_pt2! do
    read_input("./input.txt")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn([opponent_choice, result]) -> cheat(handmapper(opponent_choice), result_mapper(result)) end)
    |> Enum.sum
  end

end

# elixir -r part1_2.ex -e 'Solution'
IO.puts "Part 1 #{Solution.solve_pt1!}"
# => 14069

IO.puts "Part 2 #{Solution.solve_pt2!}"
# => 12411 

