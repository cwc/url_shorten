defmodule UrlShorten.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      UrlShorten.Repo,
      # Start the Telemetry supervisor
      UrlShortenWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: UrlShorten.PubSub},
      # Start the Endpoint (http/https)
      UrlShortenWeb.Endpoint
      # Start a worker by calling: UrlShorten.Worker.start_link(arg)
      # {UrlShorten.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UrlShorten.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UrlShortenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
