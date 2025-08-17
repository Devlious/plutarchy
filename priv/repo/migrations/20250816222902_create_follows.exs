defmodule Plutarchy.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :follower_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :followed_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      # Free initially
      add :cost, :decimal, precision: 10, scale: 2, default: 0

      timestamps()
    end

    create unique_index(:follows, [:follower_id, :followed_id])
    create index(:follows, [:follower_id])
    create index(:follows, [:followed_id])

    # Prevent self-following
    create constraint(:follows, :no_self_follow, check: "follower_id != followed_id")
  end
end
