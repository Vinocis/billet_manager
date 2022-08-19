defmodule BilletManager.InstallmentsBasis.Queries.Billet do
  alias BilletManager.InstallmentsBasis.Models.Billet

  import Ecto.Query

  def get_billets_by(params) do
    from b in Billet,
      where: ^params
  end
end
