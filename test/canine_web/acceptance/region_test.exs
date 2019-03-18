defmodule CanineWeb.RegionTest do
  @moduledoc """
  Tests for the welcome page based on region.
  """
  use Canine.AcceptanceCase, async: true
  
  @doc """
  This test will loop over the different regions defined in the constants file, create a new session setting the region in the metadata, and then checking that the expected regional greeting appears on the page.
  """
  describe "regionalism" do
    test "regions", _meta do
      for r <- regions() do
        Hound.Helpers.Session.change_session_to(r, metadata: %{region: r}) 

        navigate_to(@index_url)

        element = find_element(:id, "regional-greeting")
        text = visible_text(element)

        assert page_title() == "Bow! Wow!"
        assert text == regional_greeting(r)
        Hound.end_session
      end
    end
  end

  @doc """
  This test will sselect a Place from the radio buttons and sumbit, checking that the expected result appears on the resulting page.
  """
  describe "form" do
    test "form", _meta do
      for p <- places() do
        Hound.Helpers.Session.change_session_to(p, metadata: %{region: default_region()}) 

        navigate_to(@index_url)

        id = "input-"<>p
        element = find_element(:id, id)
        click(element)

        submit = find_element(:xpath, ~s|//input[@id='submit_whereto']|)
        # submit = find_element(:id, "submit_whereto")
        submit |> click()

        assert current_url() =~ "form"

        gp_element = find_element(:id, "going-places")
        gp_text = visible_text(gp_element)
        gp_expected = "We are going to the "<>p<>"!"

        pp_element = find_element(:id, "place-phrase")
        pp_text = visible_text(pp_element)
        pp_expected = Map.get(place_phrases(), p)

        assert page_title() == "Bow! Wow!"
        assert gp_text == gp_expected
        assert pp_text == pp_expected
        
        Hound.end_session
      end
    end
  end
  
end
