defmodule TwitterZPhx.Followings do
  import Ecto.Query, warn: false
  alias TwitterZPhx.Repo

  alias TwitterZPhx.Users.Following
  alias TwitterZPhx.Users.User

  def add_follow(%User{} = user, %User{} = follow) do
    %Following{}
    |> Following.changeset(%{user_id: user.id, follow_id: follow.id})
    |> Repo.insert()
  end

  def delete_follow(%User{} = user, %User{} = follow) do
    following = Repo.get_by(Following, user_id: user.id, follow_id: follow.id)
    if following != nil do
      Repo.delete(following)
    end
  end
end
