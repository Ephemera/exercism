defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    a = String.codepoints("abcdefghijklmnopqrstuvwxyz")
    a_map = a
            |> Enum.with_index
            |> Map.new
    aa = String.codepoints("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    aa_map = aa
            |> Enum.with_index
            |> Map.new
    

    String.codepoints(text)
    |> Enum.map(fn x -> Map.has_key?(a_map, x) && Enum.at(a, rem(a_map[x] + shift, 26)) || x end) 
    |> Enum.map(fn x -> Map.has_key?(aa_map, x) && Enum.at(aa, rem(aa_map[x] + shift, 26)) || x end) 
    |> Enum.join
  end
end
