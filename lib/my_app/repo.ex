defmodule MyApp.Repo do
  use AshPostgres.Repo, otp_app: :my_app

  import Ecto.Query, only: [from: 2]

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end

  def all_tenants do
    all(from(row in "organizations", select: fragment("? || ?", "org_", row.name)))
  end
end
