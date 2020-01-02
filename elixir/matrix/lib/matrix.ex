defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    %__MODULE__{
      matrix: input
              |> String.split("\n")
              |> Enum.map(&String.split(&1, " "))
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%{matrix: matrix}) do
    matrix
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%{matrix: matrix}) do
    matrix
    |> to_integer()
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%{matrix: matrix}, index), do: row(matrix, index)
  def row(matrix, index) do
    matrix
    |> to_integer()
    |> Enum.at(index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%{matrix: matrix}) do
    matrix
    |> to_integer()
    |> transformation()
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix
    |> columns()
    |> Enum.at(index)
  end

  defp to_integer(ll = [[_|_]|_]), do: Enum.map(ll, &to_integer/1)
  defp to_integer(l = [_|_]), do: Enum.map(l, &String.to_integer/1)

  defp transformation([[],[],[]]), do: []
  defp transformation(matrix), do: [Enum.map(matrix, &hd/1) | transformation(Enum.map(matrix, &tl/1))]
end
