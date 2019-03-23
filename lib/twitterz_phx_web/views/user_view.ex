defmodule TwitterZPhxWeb.UserView do
  use TwitterZPhxWeb, :view
  alias TwitterZPhxWeb.UserView
  alias HAL.{Document, Link}

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("login.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %Document{}
    |> Document.add_property(:id, user.id)
    |> Document.add_property(:email, user.email)
    |> Document.add_property(:name, user.name)
    |> Document.add_property(:active, user.active)
    |> Document.add_property(:token, user.token)
    |> Document.add_link(%Link{rel: :self, href: "/api/users/#{user.id}"})
  end
end
