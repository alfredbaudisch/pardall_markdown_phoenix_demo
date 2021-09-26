defmodule PardallWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PardallWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PardallWeb.PubSub},
      # Start the Endpoint (http/https)
      PardallWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PardallWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PardallWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
