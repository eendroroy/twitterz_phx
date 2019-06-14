defmodule TwitterZPhx.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :body, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:user_id, :body])
    |> validate_required([:user_id, :body])
  end
end
