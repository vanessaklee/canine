defmodule CanineWeb.FormTest do
  @moduledoc """
  Tests for the form page and its results.

  ## Validate business logic 
  
  - `Treat` must not equal to "other"
  - `Name` must not be nil or be in the list of `bad_names`

  ## Validate secretization 
  
  - `Treat` will match value in the `treats` map
  - `Name` will become its length (w/ spaces removed) as a string preceded by "#" 
  - `Color` will match a concatentation with space in-between of 
    value in `color_nouns` & `color_adj` maps

  """
  use Canine.AcceptanceCase, async: false
  alias Canine.Logic

  @moduletag timeout: 120000

  describe "form" do
    test "single combination of good inputs results in granting of password", _meta do
      Hound.start_session(metadata: %{region: default_region()})
      
      treat = "bacon"
      color = "red"
      name = "Rover" 

      fill_and_submit(treat, name, color)

      expected_barks = Logic.secretize(:n, name)
      expected_password = Logic.secretize(:t, treat) <> " " <> Logic.secretize(:c, color)

      bark_text = find_element(:id, "bark")
        |> visible_text()
      
      password_text =   find_element(:id, "password")
      |> visible_text()

      assert bark_text == expected_barks
      assert password_text == expected_password
      
      Hound.end_session
    end

    # DEMO uncomment to demo change_session_to
    # test "all permutations of good inputs result in granting of password", _meta do
    #   Hound.start_session(metadata: %{region: default_region()})
      
    #   names = ["Spot", "King Kong", "D0ris D4y*"]

    #   for color <- colors() do
    #     for treat <- good_treats() do
    #       for name <- names do
    #         Hound.Helpers.Session.change_session_to(treat<>name<>color, metadata: %{region: default_region()}) 

    #         fill_and_submit(treat, name, color)

    #         expected_barks = Logic.secretize(:n, name)
    #         expected_password = Logic.secretize(:t, treat) <> " " <> Logic.secretize(:c, color)

    #         bark_text = find_element(:id, "bark")
    #           |> visible_text()
            
    #         password_text =   find_element(:id, "password")
    #           |> visible_text()

    #         assert bark_text == expected_barks
    #         assert password_text == expected_password
            
    #         Hound.end_session
    #       end
    #     end
    #   end

    #   Hound.end_session
    # end

    test "missing data results in flash alert", _meta do
      Hound.start_session(metadata: %{region: default_region()})

      treat = "bacon"
      color = "red"
      name = nil
      
      Hound.Helpers.Session.change_session_to(:missingname, metadata: %{region: default_region()}) 

      fill_and_submit(treat, name, color)

      expected = "Enter your name."
      text = find_element(:id, "form-flash")
        |> visible_text()

      assert text =~ expected

      Hound.end_session
    end

    test "certain input results in denial of password", _meta do
      # TODO test bad name (from bad_names())
      Hound.start_session(metadata: %{region: default_region()})
      
      treat = "other"
      color = "red"
      name = "Rover"

      Hound.Helpers.Session.change_session_to(treat<>name<>color, metadata: %{region: default_region()}) 

      fill_and_submit(treat, name, color)

      expected = failure_message()
      text = find_element(:id, "error")
        |> visible_text()

      assert text == expected

      # DEMO uncomment to demo take_screenshot
      # take_screenshot(treat<>String.slice(name, 0..2)<>color<>".png")

      Hound.end_session
    end
  end

  ################## Test Functions ################## 

  @doc """
  This test receives a comination of a treat, name, and color. 
  It starts at the welcome page and submits that form. 
  On the resulting page, it enters the treat, name, and color into the form.
  Uses `fill_field` b/c `input_into_field` doesn't clear the field b4 entering new value
  It submits the form.

  """
  @spec fill_and_submit(String.t,String.t,String.t) :: atom
  def fill_and_submit(treat, name, color) do

    navigate_to(@index_url)
    find_element(:id, "input-"<>default_place())
    |> click()
    find_element(:id, "submit_whereto")
    |> click()
    assert current_url() == @form_url

    # DEMO uncomment to demo
    # :timer.sleep(1000)

    # select value from pull down 
    "document.getElementById('input-treat').value = '#{treat}'"
    |> execute_script()
    find_element(:id, "input-name")
    |> fill_field(name)
    find_element(:id, "input-"<>color)
    |> click()
    find_element(:id, "submit-answers")
    |> click()

    :ok
  end

end
