defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Enum.reduce(strand, 0, fn char, acc ->
      char == nucleotide  && acc + 1 || acc
    end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    @nucleotides
    |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, 0) end)
    |> (&(Enum.reduce(strand, &1, fn char, acc ->
      Map.has_key?(acc, char) && Map.put(acc, char, Map.get(acc, char) + 1) || Map.put(acc, char, 1) 
    end))).()
  end
end
