ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BilletManager.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
