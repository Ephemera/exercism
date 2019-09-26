defmodule PigLatin do
 
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&convert_phrase/1)
    |> Enum.join(" ")
  end

  defp convert_phrase(str) do
    rules = [
      { ~r/^([aeiou])(.*)/, fn [all, _, _] -> "#{all}ay" end },
      { ~r/^([x|y][b-df-hj-np-tv-z])(.*)/, fn [all, _, _] -> "#{all}ay" end },
      { ~r/^(ch|qu|squ|thr|th|sch)(.*)/, fn [_, first, last] -> "#{last}#{first}ay" end },
      { ~r/^([b-df-hj-np-tv-z]+)(.*)/, fn [_, first, last] -> "#{last}#{first}ay" end },
    ]

    rules
    |> Enum.find(fn {reg, _} ->
      Regex.match?(reg, str)
    end)
    |> (fn {reg, fun} ->
      Regex.run(reg, str)
      |> (fun).()
    end).()
  end
end
