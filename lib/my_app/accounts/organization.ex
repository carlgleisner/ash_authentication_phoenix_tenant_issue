defmodule MyApp.Accounts.Organization do
  use Ash.Resource,
    domain: MyApp.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: []

  attributes do
    uuid_primary_key :id

    attribute :name, :string, allow_nil?: false, public?: true

    create_timestamp :created_at
    create_timestamp :updated_at
  end

  actions do
    defaults [:create, :read, :update, :destroy]
    default_accept :*

    destroy :undo_create do
      argument :changeset, :struct do
        constraints instance_of: Ash.Changeset
      end
    end
  end

  postgres do
    table "organizations"
    repo(MyApp.Repo)

    manage_tenant do
      template(["org_", :name])
    end
  end
end
