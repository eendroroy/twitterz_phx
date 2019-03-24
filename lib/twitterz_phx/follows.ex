defmodule TwitterZPhx.Follows do
  import Ecto.Query, warn: false
  alias TwitterZPhx.Repo

  alias TwitterZPhx.Users.Follow
  alias TwitterZPhx.Users.User

  def add_follow(%User{} = user, %User{} = follow) do
    %Follow{}
    |> Follow.changeset(%{user_id: user.id, follow_id: follow.id})
    |> Repo.insert()
  end

  def delete_follow(%User{} = user, %User{} = follow) do
    follow = Repo.get_by(Follow, user_id: user.id, follow_id: follow.id)
    if follow != nil do
      Repo.delete(follow)
    end
  end
end
