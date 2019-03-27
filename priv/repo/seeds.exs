# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TwitterZPhx.Repo.insert!(%TwitterZPhx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

TwitterZPhx.Users.create_user(%{name: "user", email: "user@example.com", password: "example1"})
TwitterZPhx.Users.sign_in("user@example.com", "example1")
