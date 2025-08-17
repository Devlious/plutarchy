defmodule Plutarchy.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :blocker_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :blocked_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :reason, :string

      timestamps()
    end

    create unique_index(:blocks, [:blocker_id, :blocked_id])
    create index(:blocks, [:blocker_id])
    create index(:blocks, [:blocked_id])

    create constraint(:blocks, :no_self_block, check: "blocker_id != blocked_id")
  end
end
