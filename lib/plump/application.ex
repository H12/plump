defmodule Plump.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PlumpWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Plump.PubSub},
      # Start the Endpoint (http/https)
      PlumpWeb.Endpoint,

      # Custom applications for handling starting/stopping/advancing games
      {Plump.Boundary.GameManager, [name: Plump.Boundary.GameManager]},
      {Registry, [name: Plump.Registry.GameSession, keys: :unique]},
      {DynamicSupervisor, [name: Plump.Supervisor.GameSession, strategy: :one_for_one]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plump.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PlumpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
