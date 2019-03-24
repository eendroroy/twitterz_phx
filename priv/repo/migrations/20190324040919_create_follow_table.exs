defmodule TwitterZPhx.Repo.Migrations.CreateFollowTable do
  use Ecto.Migration

  def change do
    create table(:followings) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :follow_id, references(:users, on_delete: :delete_all), primary_key: true

      timestamps()
    end
  end
end
