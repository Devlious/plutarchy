defmodule Plutarchy.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :transaction_id, :string, null: false
      add :from_wallet_id, references(:wallets, type: :binary_id), null: false
      add :to_wallet_id, references(:wallets, type: :binary_id), null: false
      add :amount, :decimal, precision: 20, scale: 8, null: false
      # purchase, post, like, comment, transfer, reward
      add :transaction_type, :string, null: false
      # pending, completed, failed, reversed
      add :status, :string, default: "pending"
      # posts, comments, likes, etc
      add :reference_type, :string
      # ID of the related entity
      add :reference_id, :binary_id
      add :metadata, :jsonb, default: "{}"
      add :description, :string

      timestamps()
    end

    create unique_index(:transactions, [:transaction_id])
    create index(:transactions, [:from_wallet_id])
    create index(:transactions, [:to_wallet_id])
    create index(:transactions, [:transaction_type])
    create index(:transactions, [:status])
    create index(:transactions, [:reference_type, :reference_id])
    create index(:transactions, [:inserted_at])
  end
end
