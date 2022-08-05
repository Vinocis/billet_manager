defmodule BilletManager.Billets.Queries.Billet do
  alias BilletManager.Billets.Models.Billet

  import Ecto.Query

  def get_billets(params) do
    from b in Billet,
      where: ^params
  end
end
