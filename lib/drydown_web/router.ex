defmodule DrydownWeb.Router do
  use DrydownWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DrydownWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/csv", CsvController, :export
  end

  # Other scopes may use custom stacks.
  # scope "/api", DrydownWeb do
  #   pipe_through :api
  # end
end
