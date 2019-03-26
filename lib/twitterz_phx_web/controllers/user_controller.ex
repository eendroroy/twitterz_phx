defmodule TwitterZPhxWeb.UserController do
  use TwitterZPhxWeb, :controller

  alias TwitterZPhx.Follows
  alias TwitterZPhx.Repo
  alias TwitterZPhx.Users
  alias TwitterZPhx.Users.User
  alias TwitterZPhx.Services.Authenticator

  action_fallback TwitterZPhxWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("show.json", user: user)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    user = Users.login_user(email, password)
    if user == nil do
      conn
      |> put_status(:not_found)
      |> put_view(TwitterZPhxWeb.ErrorView)
      |> render(:"404")
    else
      token = Authenticator.generate_token(user)
      Repo.insert(Ecto.build_assoc(user, :auth_tokens, %{token: token}))
      render(conn, "login.json", token: token)
    end
  end

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def follow(conn, %{"follow_id" => follow_id}) do
    user = Guardian.Plug.current_resource(conn)
    follow = Users.get_user!(follow_id)
    cond do
      user == nil ->
        conn
        |> put_status(:not_found)
        |> put_view(TwitterZPhxWeb.ErrorView)
        |> render(:"404")
      follow == nil ->
        conn
        |> put_status(:not_found)
        |> put_view(TwitterZPhxWeb.ErrorView)
        |> render(:"404")
      true ->
        Follows.add_follow(user, follow)
        user = Repo.preload(user, :follows)
        follows = user.follows
        render(conn, "follows.json", follows: follows)
    end
  end

  def un_follow(conn, %{"follow_id" => follow_id}) do
    user = Guardian.Plug.current_resource(conn)
    follow = Users.get_user!(follow_id)
    cond do
      user == nil ->
        conn
        |> put_status(:not_found)
        |> put_view(TwitterZPhxWeb.ErrorView)
        |> render(:"404")
      follow == nil ->
        conn
        |> put_status(:not_found)
        |> put_view(TwitterZPhxWeb.ErrorView)
        |> render(:"404")
      true ->
        Follows.delete_follow(user, follow)
        user = Repo.preload(user, :follows)
        follows = user.follows
        render(conn, "follows.json", follows: follows)
    end
  end

  def follows(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    user = Repo.preload(user, :follows)
    follows = user.follows
    render(conn, "follows.json", follows: follows)
  end

#  def delete(conn, %{"id" => id}) do
#    user = Users.get_user!(id)
#
#    with {:ok, %User{}} <- Users.delete_user(user) do
#      send_resp(conn, :no_content, "")
#    end
#  end
end
