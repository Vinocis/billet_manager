defmodule BilletManager.InstallmentsBasis.Queries.Billet do
  alias BilletManager.InstallmentsBasis.Models.Billet

  import Ecto.Query

  @doc """
  Fetch billets with the given params
  """
  @spec get_billets_by(keyword) :: Ecto.Query.t()
  def get_billets_by(params) do
    from b in Billet,
      where: ^params
  end
end
