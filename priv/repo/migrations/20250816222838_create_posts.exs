defmodule Plutarchy.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :content, :text, null: false
      add :media_url, :string
      # image, audio, video
      add :media_type, :string
      # public, followers, private
      add :visibility, :string, default: "public"
      # draft, published, hidden, deleted
      add :status, :string, default: "published"

      # Costs and Pricing
      add :base_cost, :decimal, precision: 10, scale: 2, default: 1.0
      add :content_cost, :decimal, precision: 10, scale: 2, default: 0
      add :total_cost, :decimal, precision: 10, scale: 2, null: false

      # Counters (denormalized for performance)
      add :likes_count, :integer, default: 0
      add :comments_count, :integer, default: 0
      add :favorites_count, :integer, default: 0
      add :shares_count, :integer, default: 0

      # Search
      add :search_vector, :tsvector

      add :deleted_at, :utc_datetime
      timestamps()
    end

    create index(:posts, [:user_id])
    create index(:posts, [:status])
    create index(:posts, [:visibility])
    create index(:posts, [:inserted_at])
    create index(:posts, [:deleted_at])

    # Full-text search index
    execute "CREATE INDEX posts_search_idx ON posts USING GIN (search_vector)"

    # Trigger to update search vector
    execute """
    CREATE OR REPLACE FUNCTION update_posts_search_vector() RETURNS trigger AS $$
    BEGIN
      NEW.search_vector := to_tsvector('english', NEW.content);
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    """

    execute """
    CREATE TRIGGER update_posts_search_vector BEFORE INSERT OR UPDATE ON posts
    FOR EACH ROW EXECUTE FUNCTION update_posts_search_vector();
    """
  end
end
