defmodule BilletManager.InstallmentsBasis.Queries.Customer do
  alias BilletManager.InstallmentsBasis.Models.Customer

  import Ecto.Query

  def get_customers_by(params) do
    from c in Customer,
      where: ^params
  end

  def get_customers do
    from c in Customer,
      select: c
  end
end
