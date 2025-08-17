defmodule Plutarchy.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :balance, :decimal, precision: 20, scale: 8, default: 0
      add :pending_balance, :decimal, precision: 20, scale: 8, default: 0
      add :total_earned, :decimal, precision: 20, scale: 8, default: 0
      add :total_spent, :decimal, precision: 20, scale: 8, default: 0

      timestamps()
    end

    create unique_index(:wallets, [:user_id])
    create index(:wallets, [:balance])

    # Ensure balance never goes negative
    create constraint(:wallets, :balance_must_be_positive, check: "balance >= 0")
  end
end
