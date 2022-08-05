defmodule BilletManager.Billets.Queries.Customer do
  alias BilletManager.Billets.Models.Customer

  import Ecto.Query

  def get_customers(params) do
    from c in Customer,
      where: ^params
  end
end
