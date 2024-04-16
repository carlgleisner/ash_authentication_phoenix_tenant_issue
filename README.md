# AshAuthentication Phoenix Tenant Issue

This is a repository to demonstrate a potential issue with tenants in AshAuthentication Phoenix related to the `sign_in_tokens_enabled?`.

This repo has a hard coded tenant set by a plug as `org_cyberdyne`.

## Reproduction

```sh
mix deps.get
mix ash_postgres.create
mix ash_postgres.migrate
mix ash_postgres.migrate --tenants
mix run priv/repo/seeds.exs
iex -S mix phx.server
```

Log in as `user@example.org` with password `asdfasdf`. This should work fine.

Then comment out the line `sign_in_tokens_enabled? false` in `user.ex`, which makes the value default to true.

Try to log in again.

That should fail with the following messages:

```
[warning] Unhandled error in form submission for MyApp.Accounts.User.sign_in_with_password

This error was unhandled because Ash.Error.Invalid.TenantRequired does not implement the `AshPhoenix.FormData.Error` protocol.

** (Ash.Error.Invalid.TenantRequired) Queries against the MyApp.Accounts.User resource require a tenant to be specified

[warning] Unhandled error in form submission for MyApp.Accounts.User.sign_in_with_password

This error was unhandled because Ash.Error.Invalid.TenantRequired does not implement the `AshPhoenix.FormData.Error` protocol.

** (Ash.Error.Invalid.TenantRequired) Queries against the MyApp.Accounts.User resource require a tenant to be specified

[warning] Unhandled error in form submission for MyApp.Accounts.User.sign_in_with_password

This error was unhandled because Ash.Error.Invalid.TenantRequired does not implement the `AshPhoenix.FormData.Error` protocol.

** (Ash.Error.Invalid.TenantRequired) Queries against the MyApp.Accounts.User resource require a tenant to be specified

[warning] Unhandled error in form submission for MyApp.Accounts.User.sign_in_with_password

This error was unhandled because Ash.Error.Invalid.TenantRequired does not implement the `AshPhoenix.FormData.Error` protocol.

** (Ash.Error.Invalid.TenantRequired) Queries against the MyApp.Accounts.User resource require a tenant to be specified
```
