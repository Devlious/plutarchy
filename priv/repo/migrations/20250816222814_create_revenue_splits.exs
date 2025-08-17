defmodule Plutarchy.Repo.Migrations.CreateRevenueSplits do
  use Ecto.Migration

  def change do
    create table(:revenue_splits, primary_key: false) do
      add :id, :binary_id, primary_key: true
      # like, comment, etc.
      add :action_type, :string, null: false
      add :creator_percentage, :decimal, precision: 5, scale: 2, null: false
      add :platform_percentage, :decimal, precision: 5, scale: 2, null: false
      add :prize_pool_percentage, :decimal, precision: 5, scale: 2, null: false
      add :active, :boolean, default: true

      timestamps()
    end

    create unique_index(:revenue_splits, [:action_type], where: "active = true")

    # Insert initial splits
    execute """
    INSERT INTO revenue_splits (id, action_type, creator_percentage, platform_percentage, prize_pool_percentage, inserted_at, updated_at)
    VALUES (gen_random_uuid(), 'like', 80.00, 10.00, 10.00, NOW(), NOW())
    """

    execute """
    INSERT INTO revenue_splits (id, action_type, creator_percentage, platform_percentage, prize_pool_percentage, inserted_at, updated_at)
    VALUES (gen_random_uuid(), 'unblock', 0.00, 50.00, 50.00, NOW(), NOW())
    """

    execute """
    INSERT INTO revenue_splits (id, action_type, creator_percentage, platform_percentage, prize_pool_percentage, inserted_at, updated_at)
    VALUES (gen_random_uuid(), 'unfollow', 0.00, 50.00, 50.00, NOW(), NOW())
    """
  end
end
