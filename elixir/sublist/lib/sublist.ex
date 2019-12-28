defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a === b, do: :equal
  def compare(a, b) when length(a) > length(b), do: judge(a, b, :superlist) 
  def compare(a, b) when length(a) < length(b), do: judge(b, a, :sublist) 
  def compare(_a, _b), do: :unequal

  defp judge(list, sublist, result) when length(list) >= length(sublist) do
    cond do
      sublist === Enum.take(list, length(sublist)) -> result
      true -> judge(tl(list), sublist, result) 
    end
  end
  defp judge(_list, _sublist, _result), do: :unequal
end
