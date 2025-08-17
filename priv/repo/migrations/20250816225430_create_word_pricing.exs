defmodule Plutarchy.Repo.Migrations.CreateWordPricing do
  use Ecto.Migration

  def change do
    create table(:word_pricing_rules, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :word, :string
      # regex
      add :pattern, :string
      # positive, negative, neutral, toxic, etc.
      add :sentiment, :string
      # profanity, hate_speech, spam, promotional, etc.
      add :category, :string
      add :cost_modifier, :decimal, precision: 10, scale: 2
      add :multiplier, :decimal, precision: 5, scale: 2, default: 1.0
      add :active, :boolean, default: true

      timestamps()
    end

    create index(:word_pricing_rules, [:word])
    create index(:word_pricing_rules, [:sentiment])
    create index(:word_pricing_rules, [:category])
    create index(:word_pricing_rules, [:active])
  end
end
