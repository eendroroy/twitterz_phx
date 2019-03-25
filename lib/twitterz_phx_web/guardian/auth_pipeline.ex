defmodule TwitterZPhxWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :twitterz_phx,
                              module: TwitterZPhxWeb.Guardian,
                              error_handler: TwitterZPhxWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
