defmodule CanineWeb.WelcomeTest do
  @moduledoc """
  Tests for the welcome page.
  """
  use Canine.AcceptanceCase, async: true
  
  setup do
    Hound.start_session(metadata: %{region: nil}) 
    :ok
  end

  @doc """
  Test missing metadate affect on welcome page
  """
  describe "welcome" do
    test "welcome page loads error correctly", _meta do
      navigate_to(@index_url)

      element = find_element(:id, "welcome")
      text = visible_text(element)

      assert page_title() == "Bow! Wow!"
      assert text == "Bad Dog!"
    end
  end

end
