defmodule CanineWeb.PageView do
  use CanineWeb, :view

  def render(:signup, _assigns) do
    render "signup.html", %{}
  end
end
