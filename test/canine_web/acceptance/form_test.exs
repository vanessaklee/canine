defmodule CanineWeb.FormTest do
  @moduledoc """
  Tests for the form page and its results.

  ## Validate business logic 
  
  - `Treat` must not equal to "other"
  - `Name` must not be nil or be in the list of `bad_names`

  ## Validate secretization 
  
  - `Treat` will match it value in the `treats` map
  - `Name` will turn into a stringified number representing its length with spaces removed preceded by a "#" 
  - `Color` will match a concatentation with space in-between of its value in the `color_nouns` & `color_adj` maps

  """
  use Canine.AcceptanceCase, async: false
  alias Canine.Logic

  @moduletag timeout: 120000

  @doc """
  This test will loop over the different input combinations to check the processed outcome.
  """
  describe "form" do
    test "good form submissions", _meta do
      Hound.start_session(metadata: %{region: default_region()})
      
      names = ["Spot", "King Kong", "D0ris D4y*"]

      for color <- colors() do
        for treat <- good_treats() do
          for name <- names do
            Hound.Helpers.Session.change_session_to(treat<>name<>color, metadata: %{region: default_region()}) 

            submit_test_form(treat, name, color)

            # take_screenshot(treat<>String.slice(name, 0..2)<>color<>".png")

            # Verify number of barks
            expected_bark = Logic.secretize(:n, name)
            bark_element = find_element(:id, "bark")
            bark_text = visible_text(bark_element)
            assert bark_text == expected_bark

            # Verify password
            expected_password = Logic.secretize(:t, treat) <> " " <> Logic.secretize(:c, color)
            password_element = find_element(:id, "password")
            password_text = visible_text(password_element)
            assert password_text == expected_password
            
            # Hound.end_session
          end
        end
      end

      Hound.end_session
    end

    test "bad treat submission", _meta do
      Hound.start_session(metadata: %{region: default_region()})
      
      treat = "other"
      color = "red"
      name = "Rover"

      Hound.Helpers.Session.change_session_to(treat<>name<>color, metadata: %{region: default_region()}) 

      submit_test_form(treat, name, color)

      # Verify failure
      expected_error = failure_message()
      error_element = find_element(:id, "error")
      error_text = visible_text(error_element)
      assert error_text == expected_error

      Hound.end_session
    end

    test "missing name submission", _meta do
      Hound.start_session(metadata: %{region: default_region()})

      treat = "bacon"
      color = "red"
      name = nil
      
      Hound.Helpers.Session.change_session_to(:missingname, metadata: %{region: default_region()}) 

      submit_test_form(treat, name, color)

      # Verify error is showing
      expected_error = "Enter your name."
      error_element = find_element(:id, "form-flash")
      error_text = visible_text(error_element)
      assert error_text =~ expected_error 

      Hound.end_session
    end
  end

  def submit_test_form(treat, name, color) do
    # Start at the welcome page and submit that form first
    submit_place_form(default_place())

    assert current_url() == @form_url

    # :timer.sleep(1000)

    # select treat from pull down 
    script = "document.getElementById('input-treat').value = '#{treat}'"
    execute_script(script)

    input_name = find_element(:id, "input-name")
    input_name |> fill_field(name)

    id = "input-"<>color
    element = find_element(:id, id)
    click(element)

    submit = find_element(:id, "submit-answers")
    submit |> click()
  end

  def submit_place_form(place) do
    navigate_to(@index_url)

    find_element(:id, "input-"<>place)
    |> click()

    find_element(:id, "submit_whereto")
    |> click()
  end

end
