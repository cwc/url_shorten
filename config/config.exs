# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :url_shorten,
  ecto_repos: [UrlShorten.Repo]

# Configures the endpoint
config :url_shorten, UrlShortenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k9EVIhyNQwvIGn8rtwoni1AznHAuOK+C9gjyTeDhkP5tK3yCNqJwWO5auZlx9OFr",
  render_errors: [view: UrlShortenWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UrlShorten.PubSub,
  live_view: [signing_salt: "RYWAIuzl"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
