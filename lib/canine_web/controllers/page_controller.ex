defmodule CanineWeb.PageController do
  use CanineWeb, :controller

  import Canine.Logic
  import Canine.Constants
  import Canine.Validators

  def index(conn, _params) do
    render conn, "index.html"
  end

  def form(conn, params) do
    place = get_in(params, ["whereto", "place"])
    render conn, "form.html", place: get_in(params, ["whereto", "place"]), treats: treats(), place_phrase: make_place_phrase(place), conn: conn
  end

  def secret(conn, params) do
    name = get_in(params, ["answers", "name"])
    color = get_in(params, ["answers", "color"])
    error = valid_form_params?(name, color)
    IO.inspect error
    case error do
      nil -> 
        render conn, "secret.html", secret_password: create_secret_password(params), place: get_in(params, ["answers", "place"]), conn: conn
      _error -> 
        conn = put_flash(conn, :error, error)
        place = get_in(params, ["answers", "place"])
        render conn, "form.html", place: place, treats: treats(), place_phrase: make_place_phrase(place), conn: conn
    end
  end
end
