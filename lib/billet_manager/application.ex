defmodule BilletManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BilletManager.Repo,
      # Start the Telemetry supervisor
      BilletManagerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BilletManager.PubSub},
      # Start the Endpoint (http/https)
      BilletManagerWeb.Endpoint
      # Start a worker by calling: BilletManager.Worker.start_link(arg)
      # {BilletManager.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BilletManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BilletManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
