defmodule BilletManagerWeb.Schemas.Customer.Resolver do
  @moduledoc false

  alias BilletManager.InstallmentsBasis.Services.CreateCustomer
  alias BilletManager.InstallmentsBasis.Services.GetCustomers
  alias BilletManager.InstallmentsBasis.Services.UpdateCustomer
  alias BilletManager.InstallmentsBasis.Models.Customer

  @type changeset :: Ecto.Changeset.t()
  @type customer :: Customer.t()

  @spec get_customers(term, map, term) ::
          {:ok, list(customer)} | {:error, list()}
  def get_customers(_parent, _params, _context) do
    GetCustomers.process()
  end

  @spec create_customer(term, map, term) ::
          {:ok, customer} | {:error, changeset}
  def create_customer(_parent, %{input: input}, _context) do
    case CreateCustomer.process(input) do
      {:ok, customer} ->
        {:ok, customer}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @spec update_customer(term, map, term) ::
          {:ok, customer} | {:error, changeset}
  def update_customer(_parent, %{input: input}, _context) do
    case UpdateCustomer.process(input) do
      {:ok, customer} ->
        {:ok, customer}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
