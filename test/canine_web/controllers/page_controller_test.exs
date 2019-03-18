defmodule CanineWeb.PageControllerTest do
  use CanineWeb.ConnCase

  import Canine.Constants

  test "GET /" do
    conn = get(build_conn(), "/")
    html = html_response(conn, 200)
    contains = html =~ "Bad Dog"

    assert contains
  end

  test "POST /form" do
    conn = post(build_conn(), "/form", [place: "park", treats: treats()])
    assert conn.resp_body =~ "Bad Dog"
  end

  test "POST /secret" do
    conn = post(build_conn(), "/form", [place: "park", treats: treats()])
    assert conn.resp_body =~ "Bad Dog"
  end
end
