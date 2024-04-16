defmodule MyAppWeb.SetTenant do
  @behaviour Plug

  @impl true
  def init(options), do: options

  @impl true
  def call(conn, _opts) do
    conn |> Ash.PlugHelpers.set_tenant("org_cyberdyne")
  end
end
