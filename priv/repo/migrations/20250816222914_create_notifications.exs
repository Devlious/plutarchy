defmodule Plutarchy.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :actor_id, references(:users, type: :binary_id, on_delete: :delete_all)
      # like, comment, follow, mention, system
      add :type, :string, null: false
      # posts, comments, etc
      add :entity_type, :string
      add :entity_id, :binary_id
      add :message, :string
      add :data, :jsonb, default: "{}"
      add :read, :boolean, default: false
      add :read_at, :utc_datetime

      timestamps()
    end

    create index(:notifications, [:user_id, :read])
    create index(:notifications, [:user_id, :inserted_at])
    create index(:notifications, [:type])
  end
end
