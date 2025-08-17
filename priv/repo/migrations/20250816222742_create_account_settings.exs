defmodule Plutarchy.Repo.Migrations.CreateAccountSettings do
  use Ecto.Migration

  def change do
    create table(:account_settings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      # Privacy Settings
      # public, followers, private
      add :profile_visibility, :string, default: "public"
      add :post_visibility_default, :string, default: "public"
      # anyone, followers, none
      add :allow_messages_from, :string, default: "anyone"

      # Notification preferences
      add :notify_likes, :boolean, default: true
      add :notify_comments, :boolean, default: true
      add :notify_follows, :boolean, default: true
      add :notify_mentions, :boolean, default: true
      add :email_notifications, :boolean, default: true
      add :push_notifications, :boolean, default: true

      # Content preferences
      add :language, :string, default: "en"
      add :timezone, :string, default: "UTC"
      # low, medium, high
      add :content_filter_level, :string, default: "medium"

      timestamps()
    end

    create unique_index(:account_settings, [:user_id])
  end
end
