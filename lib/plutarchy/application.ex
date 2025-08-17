defmodule Plutarchy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PlutarchyWeb.Telemetry,
      Plutarchy.Repo,
      {DNSCluster, query: Application.get_env(:plutarchy, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Plutarchy.PubSub},
      # Start a worker by calling: Plutarchy.Worker.start_link(arg)
      # {Plutarchy.Worker, arg},
      # Start to serve requests, typically the last entry
      PlutarchyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plutarchy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PlutarchyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
