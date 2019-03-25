defmodule TwitterZPhx.Follows do
  import Ecto.Query, warn: false
  alias TwitterZPhx.Repo

  alias TwitterZPhx.Users.Follow
  alias TwitterZPhx.Users.User

  def add_follow(%User{} = user, %User{} = follow) do
    case Repo.get_by(Follow, user_id: user.id, follow_id: follow.id) do
      nil ->
        %Follow{}
        |> Follow.changeset(%{user_id: user.id, follow_id: follow.id})
        |> Repo.insert()
      _ -> ""
    end
  end

  def delete_follow(%User{} = user, %User{} = follow) do
    case Repo.get_by(Follow, user_id: user.id, follow_id: follow.id) do
      nil -> ""
      follow -> Repo.delete(follow)
      _ -> ""
    end
  end
end
