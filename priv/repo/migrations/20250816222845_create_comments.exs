defmodule Plutarchy.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :post_id, references(:posts, type: :binary_id, on_delete: :delete_all), null: false
      add :parent_comment_id, references(:comments, type: :binary_id, on_delete: :delete_all)
      add :content, :text, null: false
      add :depth, :integer, default: 0
      # Materialized path for efficient queries
      add :path, :string

      # Cost tracking
      add :cost, :decimal, precision: 10, scale: 2, default: 1.0

      # Counters
      add :likes_count, :integer, default: 0
      add :replies_count, :integer, default: 0

      add :deleted_at, :utc_datetime
      timestamps()
    end

    create index(:comments, [:user_id])
    create index(:comments, [:post_id])
    create index(:comments, [:parent_comment_id])
    create index(:comments, [:path])
    create index(:comments, [:deleted_at])

    # Prevent infinite nesting
    create constraint(:comments, :max_depth, check: "depth <= 5")
  end
end
