defmodule CanineWeb.Router do
  use CanineWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", CanineWeb do
    pipe_through :browser 

    # GET
    get "/", PageController, :index
    # POST
    post "/form", PageController, :form
    post "/secret", PageController, :secret
  end

end
