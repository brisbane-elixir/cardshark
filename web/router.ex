defmodule CardShark.Router do
  use CardShark.Web, :router

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

  scope "/", CardShark do
    pipe_through :browser
    get "/", PageController, :index
  end

  scope "/api", CardShark do
    pipe_through :api
    resources "/users", UserController
    resources "/cards", CardController
    resources "/projects", ProjectController
    resources "/boards", BoardController
  end
end
