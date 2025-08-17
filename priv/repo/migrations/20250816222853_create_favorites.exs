defmodule Plutarchy.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :post_id, references(:posts, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:favorites, [:user_id, :post_id])
    create index(:favorites, [:user_id])
    create index(:favorites, [:post_id])
  end
end
