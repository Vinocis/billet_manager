defmodule BilletManager.InstallmentsBasis.Queries.Billet do
  @moduledoc """
  Queries used to interact with the billets table
  """

  alias BilletManager.InstallmentsBasis.Models.Billet

  import Ecto.Query

  def root_query do
    from b in Billet, as: :billet
  end

  def inner_join_by_customer(query) do
    join(
      query,
      :inner,
      [billet: b],
      c in assoc(b, :customer),
      as: :customer
    )
  end

  def get_by_customer_id(query, id) do
    where(query, [customer: c], c.id == ^id)
  end

  def select_fields_for_api(query) do
    select(query, [billet: b], %{
      code: b.code,
      expire_on: b.expire_on,
      status: b.status,
      value: b.value
    })
  end
end
