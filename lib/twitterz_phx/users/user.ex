defmodule TwitterZPhx.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :active, :boolean, default: false
    field :email, :string
    field :name, :string
    field :password, :string
    field :token, :string

    has_many :_followings, TwitterZPhx.Users.Following
    has_many :followings, through: [:_followings, :following]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :name, :active, :token])
    |> validate_required([:email, :password, :name])
    |> unique_constraint(:email)
  end
end
