defmodule Canine.Secrets do

  import Canine.Constants

  def secretize(_type, value) when is_nil(value), do: ""
  def secretize(type, _value) when is_nil(type), do: ""
  def secretize(type, treat) when type == :t do 
    Map.get(treat_words(), treat)
  end
  def secretize(type, color) when type == :c do
    Map.get(color_adjs(), color) <> " " <> Map.get(color_nouns(), color)
  end
  def secretize(type, name) when type == :n do 
    "#" <> to_string(String.length(to_string(name)))
  end

end
