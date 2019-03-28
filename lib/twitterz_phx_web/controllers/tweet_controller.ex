defmodule TwitterZPhxWeb.TweetController do
  use TwitterZPhxWeb, :controller

  alias TwitterZPhx.Tweets
  alias TwitterZPhx.Tweets.Tweet

  action_fallback TwitterZPhxWeb.FallbackController

  def index(conn, _params) do
    user = conn.assigns.signed_user
    user = Repo.preload(user, :tweets)
    tweets = user.tweets
    render(conn, "index.json", tweets: tweets)
  end

  def create(conn, %{"tweet_body" => tweet_body}) do
    user = conn.assigns.signed_user
    with {:ok, %Tweet{} = tweet} <- Repo.insert(Ecto.build_assoc(user, :tweets, %{body: tweet_body})) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tweet_path(conn, :show, tweet))
      |> render("show.json", tweet: tweet)
    end
  end

  def show(conn, _params) do
    tweet = Tweets.get_tweet!(id)
    render(conn, "show.json", tweet: tweet)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}) do
    tweet = Tweets.get_tweet!(id)

    with {:ok, %Tweet{} = tweet} <- Tweets.update_tweet(tweet, tweet_params) do
      render(conn, "show.json", tweet: tweet)
    end
  end

  def delete(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)

    with {:ok, %Tweet{}} <- Tweets.delete_tweet(tweet) do
      send_resp(conn, :no_content, "")
    end
  end
end
