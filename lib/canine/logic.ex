defmodule Canine.Logic do

  import Canine.Validators
  import Canine.Secrets
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

  def make_place_phrase(place) when place == "park", do: default_phrase()
  def make_place_phrase(place) when place == "woods", do: woods_phrase()
  def make_place_phrase(place) when place == "city", do: city_phrase()
  def make_place_phrase(_place), do: default_phrase()
end
