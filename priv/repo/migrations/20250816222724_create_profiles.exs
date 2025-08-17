defmodule Plutarchy.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :display_name, :string
      add :bio, :text
      add :avatar_url, :string
      add :cover_url, :string
      add :location, :string
      add :website, :string
      add :metadata, :jsonb, default: "{}"

      timestamps()
    end

    create unique_index(:profiles, [:user_id])
    create index(:profiles, [:display_name])
  end
end
