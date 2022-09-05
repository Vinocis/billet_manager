defmodule BilletManager.InstallmentsBasis.IO.Repo.Customer do
  @moduledoc """
  Module that interacts with the customers table
  """

  use BilletManager, :repo

  alias BilletManager.InstallmentsBasis.Models.Customer

  @doc """
  Fetch all customers
  """
  @impl true
  def all do
    Repo.all(Customer)
  end

  @doc """
  Create a new customer
  """
  @impl true
  def insert(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a customer
  """
  @impl true
  def update(customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Fetch customers by params
  """
  @impl true
  def fetch_by(params) do
    fetch_by(Customer, params)
  end
end
