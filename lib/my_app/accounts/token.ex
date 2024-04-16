defmodule MyApp.Accounts.Token do
  use Ash.Resource,
    domain: MyApp.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]

  token do
    domain MyApp.Accounts
  end

  multitenancy do
    strategy :context
  end

  postgres do
    table "tokens"
    repo(MyApp.Repo)
  end

  # If using policies, add the following bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
