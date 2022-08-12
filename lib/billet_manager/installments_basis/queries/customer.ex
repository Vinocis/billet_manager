defmodule BilletManager.InstallmentsBasis.Queries.Customer do
  alias BilletManager.InstallmentsBasis.Models.Customer

  import Ecto.Query

  def get_customers(params) do
    from c in Customer,
      where: ^params
  end

  def get_all_customers do
    from c in Customer,
      select: c
  end
end
