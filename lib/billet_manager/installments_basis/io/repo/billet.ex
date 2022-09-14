defmodule BilletManager.InstallmentsBasis.IO.Repo.Billet do
  @moduledoc """
  Module that interacts with the billets table
  """

  use BilletManager, :repo

  alias BilletManager.InstallmentsBasis.Models.Billet
  alias BilletManager.InstallmentsBasis.Queries.Billet, as: BilletQueries

  @doc """
  Create a new bank billet
  """
  @impl true
  def insert(attrs) do
    %Billet{}
    |> Billet.changeset(attrs)
    |> Repo.insert()
  end

  def get_billets_by_customer_id(customer_id) do
    BilletQueries.root_query()
    |> BilletQueries.inner_join_by_customer()
    |> BilletQueries.get_by_customer_id(customer_id)
    |> BilletQueries.select_fields_for_api()
    |> Repo.all()
  end
end
