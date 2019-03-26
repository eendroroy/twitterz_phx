# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :twitterz_phx,
  namespace: TwitterZPhx,
  ecto_repos: [TwitterZPhx.Repo]

# Configures the endpoint
config :twitterz_phx, TwitterZPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7fyI6pxHjRi8p3iwVe68vuEqJZls400h3EvuuHGGerGTBjBVckgnmzrVpQBmHVCi",
  render_errors: [view: TwitterZPhxWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TwitterZPhx.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
