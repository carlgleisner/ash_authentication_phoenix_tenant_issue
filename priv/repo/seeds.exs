# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

MyApp.Accounts.Organization
|> Ash.Changeset.for_create(:create, %{name: "cyberdyne"})
|> Ash.create!()

MyApp.Accounts.User
|> Ash.Changeset.for_create(
  :register_with_password,
  %{email: "user@example.com", password: "asdfasdf", password_confirmation: "asdfasdf"},
  tenant: "org_cyberdyne"
)
|> Ash.create!()
