defmodule Canine.Logic do
  @moduledoc """
  Validate form data against business logic.

  ## Validation business logic 
  `Treat` if valid if

    - it is not equal to "other"

  `Name` if valid if

    - it is not nil
    - it is not in the `bad_names` list: ["hitler", "brutus", "killer"]

  `Color` is always valid 

  ## Secretization business logic 
  `Treat` 

    - the treat is key in `constants` map used to return a value 

  `Name` 

    - turned into a number that is its length stringified and concantegnated with '#'

  `Color` 

    - the color is key in two `constants` map used to return a two values
      - a noun
      - an adjective

  """
  import Canine.Constants

  def create_secret_password(params) do
    name = get_in(params, ["answers", "name"])
    treat = get_in(params, ["answers", "treat"])
    color = get_in(params, ["answers", "color"])

    case valid?(:n, name) && valid?(:t, treat) && valid?(:c, color) do
      true -> 
        %{:bark => secretize(:n, name), :speak => secretize(:t, treat) <> " " <> secretize(:c, color)}
      false -> nil
    end
  end
  
  def valid?(_type, value) when is_nil(value), do: false
  def valid?(type, _value) when is_nil(type), do: false
  def valid?(type, name) when type == :n do
    name
    |> String.trim()
    |> String.downcase()
    |> String.replace(" ", "")
    |> good?()
  end
  def valid?(type, treat) when type == :t do
    treat != "other"
  end
  def valid?(type, _color) when type == :c, do: true

  def good?(name), do: name not in bad_names()

  def valid_form_params?(name, color) do
    case missing_value(name) do
      true -> missing_name_error()
      false -> 
        case missing_value(color) do
          true -> missing_color_error()
          false -> nil
        end
    end
  end

  def missing_value(value) do
    is_nil(value) || value == ""
  end

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

  def make_place_phrase(place) when is_nil(place), do: nil
  def make_place_phrase(place), do: place_phrase(place)
end
