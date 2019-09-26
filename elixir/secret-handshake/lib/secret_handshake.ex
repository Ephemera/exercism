defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    handshake = ["wink", "double blink", "close your eyes", "jump", nil]

    result = Integer.digits(code, 2) 
    |> Enum.reverse
    |> (&(Enum.zip([&1, handshake]))).() 
    |> Enum.map(fn x -> elem(x, 0) == 1 && elem(x, 1) || nil  end) 
    |> Enum.reject(&is_nil/1)

    code > 0b10000 && Enum.reverse(result) || result
  end
end
