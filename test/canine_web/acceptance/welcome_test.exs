defmodule HoundTest do
  @moduledoc """
  Tests for the welcome page.
  """

  use ExUnit.Case
  use Hound.Helpers
  import CanineWeb.Router.Helpers
  import CanineWeb.TestHelpers

  @page_url page_url(CanineWeb.Endpoint, :index)
  @form_url user_url(CanineWeb.Endpoint, :form)

  setup do
    Hound.start_session(metadata: metadata) # move into tests when metadata needs to change
    :ok
  end

  describe "welcomepage" do
    test "Welcome page loads successfully", _meta do
      navigate_to(@page_url)
      assert page_title() == "Bow! Wow!"
    end
  end

  describe "good form" do
    test "successfull form submission", _meta do
      navigate_to(@form_url)

      element = find_element(:link_text, "Register")
      element |> click()

      name = find_element(:xpath, ~s|//*[@id="user_name"]|)
      name |> fill_field("Meraj")

      username = find_element(:xpath, ~s|//*[@id="user_username"]|)
      username |> fill_field("meraj")

      password = find_element(:xpath, ~s|//*[@id="user_password"]|)
      password |> fill_field("password")

      submit = find_element(:xpath, ~s|/html/body/div/main/form/div[4]/button|)
      submit |> click()

      assert current_url() == @user_url
      assert page_source() =~ "Listing Users"
      assert page_source() =~ "meraj"
    end
  end

  describe "bad form" do
    test "failed form", _meta do
      user = insert_user()
      navigate_to(@page_url)

      element = find_element(:link_text, "Log In")
      element |> click()

      username = find_element(:xpath, ~s|//*[@id="session_username"]|)
      username |> fill_field(user.name)

      password = find_element(:xpath, ~s|//*[@id="session_password"]|)
      password |> fill_field(user.password)

      submit = find_element(:xpath, ~s|/html/body/div/main/form/button|)
      submit |> click()

      assert current_url() == @user_url
      assert page_source() =~ "Listing Users"
      assert page_source() =~ "meraj"
    end
  end
end
