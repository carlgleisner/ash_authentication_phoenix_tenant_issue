defmodule MyApp.Accounts do
  use Ash.Domain,
    extensions: []

  resources do
    resource MyApp.Accounts.User
    resource MyApp.Accounts.Token
    resource MyApp.Accounts.Organization
  end
end
