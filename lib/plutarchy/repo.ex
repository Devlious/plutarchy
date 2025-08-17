defmodule Plutarchy.Repo do
  use Ecto.Repo,
    otp_app: :plutarchy,
    adapter: Ecto.Adapters.Postgres
end
