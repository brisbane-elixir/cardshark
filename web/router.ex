defmodule CardShark.Router do
  use CardShark.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
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
  end

  socket "/ws", CardShark do
    channel "stream", StreamChannel
  end
end
