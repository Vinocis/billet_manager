defmodule BilletManager.Repo do
  use Ecto.Repo,
    otp_app: :billet_manager,
    adapter: Ecto.Adapters.Postgres
end
