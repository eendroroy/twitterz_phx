defmodule TwitterZPhx.Repo do
  use Ecto.Repo,
    otp_app: :twitterz_phx,
    adapter: Ecto.Adapters.Postgres
end
