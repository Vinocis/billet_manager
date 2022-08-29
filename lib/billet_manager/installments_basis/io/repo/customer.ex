defmodule BilletManager.InstallmentsBasis.IO.Repo.Customer do
  @moduledoc """
  Module that interacts with the billets table
  """

  use BilletManager, :repo

  alias BilletManager.InstallmentsBasis.Models.Customer

  @type customer :: Customer.t()

  @doc """
  Fetch all customers
  """
  @impl true
  @spec all() :: list(customer)
  def all do
    Repo.all(Customer)
  end

  @doc """
  Create a new customer
  """
  @impl true
  @spec insert(map) :: {:ok, customer} | {:error, changeset}
  def insert(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a customer
  """
  @impl true
  @spec update(customer, map) :: {:ok, customer} | {:error, changeset}
  def update(attrs, customer) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Fetch customers by params
  """
  @impl true
  @spec fetch_by(keyword) :: {:ok, customer} | {:error, binary}
  def fetch_by(params) do
    fetch_by(Customer, params)
  end
end
