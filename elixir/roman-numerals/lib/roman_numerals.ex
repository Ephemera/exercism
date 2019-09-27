defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    range(number)
  end

  defp match(0, result) do
    result    
  end

  defp match(n, result) do
    # |> Enum.find(fn { x, str } ->
    #   # n > x && {n - x, result <> str} || {n,  
    # end)
  end

  defp range(number) do
    %{
      1000: [ "M" ],
      100: [ "C", "D" ],
      10: [ "X", "L" ],
      1: [ "I", "V" ],
    }
    |> Enum.reduce({"", n}, fn { level, strs }, acc ->
      if number / level > 1 do
        result = case number / level do
          n in 1..3 -> {number - n, "" + String.duplicate("I", n)}
          n == 4 -> {number - n, "IV"
          n in 5..8 -> "V" + String.duplicate("I", n-5)
          n == 9 -> "IX"
        end
      else
      end
    end)

    cond do
      n -> cond do
        n in 1..3 -> "" + String.duplicate("I", n)
        n == 4 -> "IV"
        n in 5..8 -> "V" + String.duplicate("I", n-5)
        n == 9 -> "IX"
      end
    end
  end
end
