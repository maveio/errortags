defmodule Errortags.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Errortags.Repo,
      # Start the Telemetry supervisor
      ErrortagsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Errortags.PubSub},
      # Start the Endpoint (http/https)
      ErrortagsWeb.Endpoint
      # Start a worker by calling: Errortags.Worker.start_link(arg)
      # {Errortags.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Errortags.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ErrortagsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
