defmodule BilletManager.InstallmentsBasis.Queries.Customer do
  alias BilletManager.InstallmentsBasis.Models.Customer

  import Ecto.Query

  @doc """
  Fetch customers that match the given params
  """
  @spec get_customers_by(keyword) :: Ecto.Query.t()
  def get_customers_by(params) do
    from c in Customer,
      where: ^params
  end

  @doc """
  Fetch all users
  """
  @spec get_customers() :: Ecto.Query.t()
  def get_customers do
    from c in Customer,
      select: c
  end
end
