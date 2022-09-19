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

  @impl true
  @doc """
  Update a billet
  """
  def update(billet, attrs) do
    billet
    |> Billet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Fetch billets by params
  """
  @impl true
  def fetch_by(params) do
    fetch_by(Billet, params)
  end

  @doc """
  Fetch all billets linked to the customer_id 
  passed as a parameter

  ##Example
    iex> BilletManager.InstallmentsBasis.IO.Repo.Billet.get_billets_by_customer_id(1)
    [
      %{
        code: "3codfe214f",
        expire_on: ~D[2022-10-03],
        paid_value: nil
        status: :opened,
        value: %Money{amount: 1111, currency: :BRL}
      }
    ]
  """
  def get_billets_by_customer_id(customer_id) do
    BilletQueries.root_query()
    |> BilletQueries.inner_join_by_customer()
    |> BilletQueries.get_by_customer_id(customer_id)
    |> BilletQueries.select_fields_for_api()
    |> Repo.all()
  end
end
