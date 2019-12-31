defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn c -> 
      String.downcase(base) != String.downcase(c) && to_list(base) == to_list(c)
    end)
  end

  defp to_list(word) do
    word
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
  end
end
