defmodule Canine.Constants do

  @places ["park", "woods", "city"]
  @treats ["bacon", "bisquits", "rawhide", "other"]
  @colors ["black", "brown", "yellow", "white", "red", "other"]
  @regions ["northeast", "midwest", "south", "west"]

  @default_place "park"

  @color_nouns %{"black" => "Hydrant", "brown" => "Ball", "yellow" => "Mud", "white" => "Squirrel", "red" => "Leash", "other" => "Mutt"}
  @color_adjs %{"black" => "Howling", "brown" => "Bounding", "yellow" => "Magnanimus", "white" => "Scamping", "red" => "Laser", "other" => "Mystery"}
  @treat_words %{"bacon" => "Pup-tent", "peanut_butter" => "Dog-gone", "bisquits" => "Fur-ocious", "rawhide" => "Hot-dog", "cheese" => "Pup-arazzi", "other" => "Re-tail"}

  @default_region "midwest"

  @default_phrase "Watch for squirrels!"
  @woods_phrase "Watch for fetching sticks!"
  @city_phrase "Watch out for cars!"
  @place_phrases %{"park" => @default_phrase, "woods" => @woods_phrase, "city" => @city_phrase}

  @missing_name_error "Enter your name. "
  @missing_color_error "Choose a color. "

  @regional_greetings %{"northeast" => "How yoo doin'?", "midwest" => "How are ya now?", "south" => "Hey, y'all!", "west" => "Dude!"}

  @bad_names ["hitler", "brutus", "killer"]

  # error messages
  @failure_message "You do not meet the requirements for the VIP Dog Club"

  def places, do: @places
  def treats, do: @treats
  def colors, do: @colors
  def regions, do: @regions

  def default_place, do: @default_place
  def default_region, do: @default_region

  def treat_words, do: @treat_words
  def color_nouns, do: @color_nouns
  def color_adjs, do: @color_adjs

  def default_phrase, do: @default_phrase
  def woods_phrase, do: @woods_phrase
  def city_phrase, do: @city_phrase
  def place_phrases, do: @place_phrases
  def place_phrase(place), do: Map.get(@place_phrases, place) 

  def missing_name_error, do: @missing_name_error
  def missing_color_error, do: @missing_color_error

  def regional_greeting(region) when is_nil(region), do: ""
  def regional_greeting(region) do
    case Map.get(@regional_greetings, region) do
      nil -> ""
      greeting -> greeting
    end
  end

  def bad_names, do: @bad_names

  # errors
  def failure_message, do: @failure_message

end

