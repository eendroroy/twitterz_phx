defmodule TwitterZPhxWeb.UserController do
  use TwitterZPhxWeb, :controller

  alias TwitterZPhxWeb.Guardian
  alias TwitterZPhx.Followings
  alias TwitterZPhx.Users
  alias TwitterZPhx.Users.User

  action_fallback TwitterZPhxWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    user = Users.login_user(email, password)
    if user == nil do
      conn
      |> put_status(:not_found)
      |> put_view(TwitterZPhxWeb.ErrorView)
      |> render(:"404")
    else
      with {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
        with {:ok, %User{} = user} <- Users.update_user(user, %{token: token}) do
          render(conn, "login.json", user: user)
        end
      end
    end

  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def follow(conn, %{"id" => id, "follow_id" => follow_id}) do
    user = Users.get_user!(id)
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
        Followings.add_follow(user, follow)
    end
  end

  def un_follow(conn, %{"id" => id, "follow_id" => follow_id}) do
    user = Users.get_user!(id)
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
        Followings.delete_follow(user, follow)
    end
  end

#  def delete(conn, %{"id" => id}) do
#    user = Users.get_user!(id)
#
#    with {:ok, %User{}} <- Users.delete_user(user) do
#      send_resp(conn, :no_content, "")
#    end
#  end
end
