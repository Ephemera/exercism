defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(~r/([a-zA-Z ])\1*/, string)
    |> Enum.map_join(fn [match, s] ->
      "#{match == s && "" || String.length(match)}#{s}"
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/([0-9]*)([a-zA-Z ])/, string, capture: :all_but_first)
    |> Enum.map_join(fn [n, s] ->
      String.duplicate(s, n == "" && 1 || String.to_integer(n))
    end)
  end
end
