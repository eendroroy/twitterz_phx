defmodule TwitterZPhxWeb.Router do
  use TwitterZPhxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TwitterZPhxWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :update]
    post "/users/login", UserController, :login
    post "/users/register", UserController, :create
  end
end
