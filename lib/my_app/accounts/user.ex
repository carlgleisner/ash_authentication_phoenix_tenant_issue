defmodule MyApp.Accounts.User do
  use Ash.Resource,
    domain: MyApp.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication],
    authorizers: [Ash.Policy.Authorizer]

  attributes do
    uuid_primary_key :id

    attribute :email, :ci_string, allow_nil?: false, public?: true
    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  authentication do
    domain MyApp.Accounts

    strategies do
      password :password do
        identity_field :email
        sign_in_tokens_enabled? false
      end
    end

    tokens do
      enabled? true
      token_resource MyApp.Accounts.Token

      signing_secret fn _, _ ->
        {:ok, "meow"}
      end
    end
  end

  actions do
    defaults [:read, :update, :destroy]
  end

  identities do
    identity :unique_email, [:email]
  end

  # A lax policy for seeding the database
  policies do
    bypass always() do
      authorize_if always()
    end
  end

  multitenancy do
    strategy :context
  end

  postgres do
    table "users"
    repo(MyApp.Repo)
  end
end
