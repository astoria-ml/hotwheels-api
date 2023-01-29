defmodule HotwheelsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HotwheelsApiWeb.Telemetry,
      # Start the Ecto repository
      HotwheelsApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HotwheelsApi.PubSub},
      # Start Finch
      {Finch, name: HotwheelsApi.Finch},
      # Start the Endpoint (http/https)
      HotwheelsApiWeb.Endpoint
      # Start a worker by calling: HotwheelsApi.Worker.start_link(arg)
      # {HotwheelsApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HotwheelsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HotwheelsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
