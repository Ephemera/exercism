defmodule Scrabble do
  @letter_values [
                   {1, ~w(A E I O U L N R S T)},
                   {2, ~w(D G)},
                   {3, ~w(B C M P)},
                   {4, ~w(F H V W Y)},
                   {5, ~w(K)},
                   {8, ~w(J X)},
                   {10, ~w(Q Z)}
                 ]
                 |> Enum.reduce(%{}, fn {k, v}, acc ->
                   v
                   |> Enum.reduce(%{}, &Map.put(&2, &1, k))
                   |> Map.merge(acc)
                 end)

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.split(~r/\s*/, trim: true)
    |> Enum.reduce(0, &(&2 + Map.get(@letter_values, &1)))
  end
end
