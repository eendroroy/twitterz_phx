defmodule TwitterZPhx.Users.Follow do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias TwitterZPhx.Users.User

  schema "followings" do
    belongs_to :user, User
    belongs_to :follow, User
    timestamps()
  end

  @doc false
  def changeset(follow, attrs) do
    follow
    |> cast(attrs, [:user_id, :follow_id])
    |> validate_required([:user_id, :follow_id])
  end
end
