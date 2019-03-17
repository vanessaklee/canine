defmodule Canine.Validators do
  
  import Canine.Constants

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
    treat != :other
  end
  def valid?(type, color) when type == :c, do: true

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

  def good?(name), do: name not in ["hitler", "brutus", "killer"]

  def missing_value(value) do
    is_nil(value) || value == ""
  end
end
