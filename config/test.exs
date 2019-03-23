use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :twitterz_phx, TwitterZPhxWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :twitterz_phx, TwitterZPhx.Repo,
  username: "postgres",
  password: "postgres",
  database: "twitterz_phx_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
