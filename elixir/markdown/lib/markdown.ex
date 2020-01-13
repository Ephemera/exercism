defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join("", &process/1)
    |> wrap_ul_tag_if_list_tag()
  end

  defp process(line = "#" <> _) do
    line 
    |> String.split()
    |> enclose_with_header_tag()
  end
  defp process("* " <> line) do
    line 
    |> String.split()
    |> enclose_with_list_tag()
  end
  defp process(line) do
    line 
    |> String.split()
    |> enclose_with_paragraph_tag()
  end

  defp enclose_with_header_tag([hashes | words]), do: "<h#{String.length(hashes)}>#{Enum.join(words, " ")}</h#{String.length(hashes)}>"
  defp enclose_with_list_tag(words), do: "<li>#{join_words_with_tags(words)}</li>"
  defp enclose_with_paragraph_tag(words), do: "<p>#{join_words_with_tags(words)}</p>"

  defp join_words_with_tags(words) do
    words 
    |> Enum.map_join(" ", &replace_emphasis_with_tag/1)
  end

  defp replace_emphasis_with_tag(word) do
    case Regex.run(~r/^([_]{0,2})([^_]+)([_]{0,2})$/, word) do
      [_, "__", content, "__"] -> "<strong>#{content}</strong>"
      [_, "__", content, ""] -> "<strong>#{content}"
      [_, "", content, "__"] -> "#{content}</strong>"
      [_, "_", content, "_"] -> "<em>#{content}</em>"
      [_, "_", content, ""] -> "<em>#{content}"
      [_, "", content, "_"] -> "#{content}</em>"
      [_, "", content, ""] -> content 
    end
  end

  defp wrap_ul_tag_if_list_tag(content) do
    content 
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
