defmodule Bob do
  def hey(input) do
    cond do
      empty?(input) -> "Fine. Be that way!"
      upcase?(input) and question?(input) -> "Calm down, I know what I'm doing!"
      upcase?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp empty?(str) do
    String.trim(str) == ""
  end

  defp upcase?(str) do
    String.upcase(str) != String.downcase(str) and String.upcase(str) == str
  end

  defp question?(str) do
    String.ends_with?(str, "?")
  end
end
