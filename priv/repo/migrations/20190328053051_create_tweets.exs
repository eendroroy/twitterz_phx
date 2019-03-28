defmodule TwitterZPhx.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :body, :text

      timestamps()
    end

  end
end
