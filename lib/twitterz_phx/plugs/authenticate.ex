defmodule TwitterZPhx.Plugs.Authenticate do
  @moduledoc false
  import Plug.Conn

  alias TwitterZPhx.Repo
  alias TwitterZPhx.Services.Authenticator
  alias TwitterZPhx.Users.AuthToken

  def init(default), do: default

  def call(conn, _default) do
    case Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        auth_token = Repo.get_by(AuthToken, %{token: token, revoked: false})
        case auth_token do
          nil -> unauthorized(conn)
          auth_token -> authorized(conn, Repo.preload(auth_token, :user).user)
        end
      _ -> unauthorized(conn)
    end
  end

  defp authorized(conn, user) do
    conn
    |> assign(:signed_in, true)
    |> assign(:signed_user, user)
  end

  defp unauthorized(conn) do
    conn |> send_resp(401, "Unauthorized") |> halt()
  end
end
