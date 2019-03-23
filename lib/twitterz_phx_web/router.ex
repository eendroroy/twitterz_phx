defmodule TwitterZPhxWeb.Router do
  use TwitterZPhxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TwitterZPhxWeb do
    pipe_through :api

    resources "/users", UserController
  end
end
