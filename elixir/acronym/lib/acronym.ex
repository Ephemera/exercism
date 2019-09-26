defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/([ -])|(?=[A-Z])/)
    |> Enum.reject(fn s -> s == "" end) 
    |> Enum.map(fn s -> String.first(s) end)
    |> Enum.join
    |> String.upcase
  end
end
