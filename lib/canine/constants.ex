defmodule Canine.Constants do

  @treats ["Bacon": :bacon, "Peanut Butter": :peanut_butter, "Bisquits": :bisquits, "Rawhide": :rawhide, "Cheese": :cheese, "Other": :other]

  @color_nouns %{"black" => "Hydrant", "brown" => "Ball", "yellow" => "Mud", "white" => "Squirrel", "red" => "Leash", "other" => "Mutt"}
  @color_adjs %{"black" => "Howling", "brown" => "Bounding", "yellow" => "Magnanimus", "white" => "Scamping", "red" => "Laser", "other" => "Mystery"}
  @treat_words %{"bacon" => "Pup-tent", "peanut_butter" => "Dog-gone", "bisquits" => "Fur-ocious", "rawhide" => "Hot-dog", "cheese" => "Pup-arazzi", "other" => "Re-tail"}

  @default_phrase "Watch for squirrels!"
  @woods_phrase "Watch for fetching sticks!"
  @city_phrase "Watch out for cars!"

  @missing_name_error "Enter your name. "
  @missing_color_error "Choose a color. "

  def treats, do: @treats

  def treat_words, do: @treat_words
  def color_nouns, do: @color_nouns
  def color_adjs, do: @color_adjs

  def default_phrase, do: @default_phrase
  def woods_phrase, do: @woods_phrase
  def city_phrase, do: @city_phrase

  def missing_name_error, do: @missing_name_error
  def missing_color_error, do: @missing_color_error

end

