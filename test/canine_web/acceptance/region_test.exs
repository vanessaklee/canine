defmodule CanineWeb.RegionTest do
  @moduledoc """
  Tests for the effect of REGION on the welcome page and PLACE on the form page.
  """
  use Canine.AcceptanceCase, async: true
  
  @doc """
  Loop over REGIONS defined in the constants file.
  Create a new session putting  region in the metadata.
  Check for expected regional greeting on the page.
  """
  describe "regionalism" do
    test "expected regional message appears", _meta do
      for r <- regions() do
        Hound.Helpers.Session.change_session_to(r, metadata: %{region: r}) 

        navigate_to(@index_url)

        text = find_element(:id, "regional-greeting")
          |> visible_text()

        assert page_title() == "Bow! Wow!"
        assert text == Map.get(regional_greetings(), r)
        Hound.end_session
      end
    end
  end

  @doc """
  Select a PLACE from the radio buttons on the welcome page and sumbit.
  Check for expected result on the page.
  """
  describe "place" do
    test "expected place-specific message appears", _meta do
      for p <- places() do
        Hound.Helpers.Session.change_session_to(p, metadata: %{region: default_region()}) 

        navigate_to(@index_url)

        find_element(:id, "input-"<>p)
        |> click()

        # find_element(:id, "submit_whereto")
        find_element(:xpath, ~s|//input[@id='submit_whereto']|)
        |> click()

        assert current_url() =~ "form"

        gp_text =find_element(:id, "going-places")
          |> visible_text()

        pp_text = find_element(:id, "place-phrase")
          |> visible_text()

        assert page_title() == "Bow! Wow!"
        assert gp_text == "We are going to the "<>p<>"!"
        assert pp_text == Map.get(place_phrases(), p)

        Hound.end_session
      end
    end
  end
end
