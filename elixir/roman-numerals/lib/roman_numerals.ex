defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    romans = ["", "", "M", "D", "C", "L", "X", "V", "I"]
    numbers = [1000, 100, 10, 1]

    numbers
    |> Enum.zip(Enum.chunk_every(romans, 3, 2))
    |> Enum.reduce(["", number], fn {k, v}, [str, n] ->
      case trunc(n / k) do
        x when x == 0 ->
          [str, n]

        x when x in 1..3 ->
          [str <> String.duplicate(Enum.at(v, 2), x), n - x * k]

        x when x == 4 ->
          [str <> Enum.at(v, 2) <> Enum.at(v, 1), n - x * k]

        x when x in 5..8 ->
          [str <> Enum.at(v, 1) <> String.duplicate(Enum.at(v, 2), x - 5), n - x * k]

        x when x == 9 ->
          [str <> Enum.at(v, 2) <> Enum.at(v, 0), n - x * k]
      end
    end)
    |> Enum.at(0)
  end
end
