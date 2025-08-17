defmodule Plutarchy.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      # posts, comments, etc.
      add :likeable_type, :string, null: false
      add :likeable_id, :binary_id, null: false
      add :cost, :decimal, precision: 10, scale: 2, default: 1.0

      timestamps()
    end

    create unique_index(:likes, [:user_id, :likeable_type, :likeable_id])

    create index(:likes, [:likeable_type, :likeable_id])
    create index(:likes, [:user_id])
  end
end
