defmodule TwitterZPhxWeb.Router do
  use TwitterZPhxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug TwitterZPhxWeb.Guardian.AuthPipeline
  end

  scope "/api", TwitterZPhxWeb do
    pipe_through :api

    post "/users/login", UserController, :login
    post "/users/register", UserController, :create
  end

  scope "/api", TwitterZPhxWeb do
    pipe_through [:api, :authenticated]

    get "/users/profile", UserController, :show
    put "/users/profile/update", UserController, :update

    get "/users/follows", UserController, :follows
    post "/users/follow", UserController, :follow
    post "/users/un_follow", UserController, :un_follow
  end
end
