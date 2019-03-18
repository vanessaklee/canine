defmodule Canine.Constants do
  @moduledoc """
  Reused values
  """

  # LISTS
  @places ["park", "woods", "city"]
  @treats ["bacon", "bisquits", "rawhide", "other"]
  @colors ["black", "brown", "yellow", "white", "red", "other"]
  @regions ["northeast", "midwest", "south", "west"]
  @bad_names ["hitler", "brutus", "killer"]

  # DEFAULT VALUES
  @default_place "park"
  @default_region "midwest"
  @default_phrase "Watch for squirrels!"

  # MAPS
  @regional_greetings %{"northeast" => "How yoo doin'?", "midwest" => "How are ya now?", "south" => "Hey, y'all!", "west" => "Dude!"}
  @color_nouns %{"black" => "Hydrant", "brown" => "Ball", "yellow" => "Mud", "white" => "Squirrel", "red" => "Leash", "other" => "Mutt"}
  @color_adjs %{"black" => "Howling", "brown" => "Bounding", "yellow" => "Magnanimus", "white" => "Scamping", "red" => "Laser", "other" => "Mystery"}
  @treat_words %{"bacon" => "Pup-tent", "peanut_butter" => "Dog-gone", "bisquits" => "Fur-ocious", "rawhide" => "Hot-dog", "cheese" => "Pup-arazzi", "other" => "Re-tail"}
  @place_phrases %{"park" => @default_phrase, "woods" => "Watch for fetching sticks!", "city" => "Watch out for cars!"}

  # ERROR MESSAGES
  @missing_name_error "Enter your name. "
  @missing_color_error "Choose a color. "
  @failure_message "You do not meet the requirements for the VIP Dog Club"


  ################## Functions ################## 

  # RETURN VALUE
  def place_phrase(place), do: Map.get(@place_phrases, place) 

  # RETURN DEFAULT VALUE
  def default_place, do: @default_place
  def default_region, do: @default_region
  def default_phrase, do: @default_phrase

  # RETURN LIST
  def places, do: @places
  def treats, do: @treats
  def good_treats, do: @treats |> List.delete("other")
  def colors, do: @colors
  def regions, do: @regions
  def bad_names, do: @bad_names

  # RETURN MAP
  def treat_words, do: @treat_words
  def color_nouns, do: @color_nouns
  def color_adjs, do: @color_adjs
  def place_phrases, do: @place_phrases
  def regional_greetings, do: @regional_greetings

  # RETURN ERROR
  def missing_name_error, do: @missing_name_error
  def missing_color_error, do: @missing_color_error
  def failure_message, do: @failure_message

end

