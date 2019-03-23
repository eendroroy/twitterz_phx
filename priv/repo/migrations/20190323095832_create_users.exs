defmodule TwitterZPhx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :token, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
