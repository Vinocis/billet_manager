defmodule BilletManager.InstallmentsBasis do
  @moduledoc """
  The public api module of the Installments Basis context.

  Here is where are the functions that the other contexts will
  use to interact with all the Installments Basis context.
  """

  alias BilletManager.InstallmentsBasis.Db
  alias BilletManager.InstallmentsBasis.Logic.Billet, as: BilletLogic
  alias BilletManager.InstallmentsBasis.Logic.Customer, as: CustomerLogic
  alias BilletManager.InstallmentsBasis.Models.Customer
  alias BilletManager.InstallmentsBasis.Models.Billet

  defdelegate get_customer_by_params(params), to: Db
  defdelegate create_billet(attrs), to: Db, as: :insert_billet
  defdelegate create_customer(attrs), to: Db, as: :insert_customer

  @doc """
  Search a customer with the given cpf and updates his data
  with the given attrs.
  """
  @spec update_customer(map, binary) ::
          {:ok, Customer.t()} | {:error, Ecto.Changeset.t()} | {:error, atom}
  def update_customer(attrs, customer_cpf) do
    case Db.get_customer_by_params(cpf: customer_cpf) do
      nil ->
        {:error, :customer_not_found}

      customer ->
        Db.update_customer(customer, attrs)
    end
  end

  @doc """
  Converts the pagination data to a keyword list and 
  then pass it to the Db module function that build the
  pagination map.
  """
  @spec list_customers_with_pagination(map) :: map
  def list_customers_with_pagination(pagination_data) do
    pagination_data =
      pagination_data
      |> Map.from_struct()
      |> Map.to_list()

    Db.get_customers_with_pagination(pagination_data)
  end
end
