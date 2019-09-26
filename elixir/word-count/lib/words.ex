defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(~r/[,_:!&@$%^& ]+/)
    |> Enum.reduce(%{}, fn word, acc -> word != "" && Map.update(acc, word, 1, &(&1 + 1)) || acc end)
  end
end
