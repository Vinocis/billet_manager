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

  @spec create_customer(map) :: {:ok, Customer.t()} | {:error, Ecto.Changeset.t()}
  def create_customer(attrs) do
    attrs = CustomerLogic.attrs_for_create(attrs)

    Db.insert_customer(attrs)
  end

  @spec update_customer(map, binary) ::
          {:ok, Customer.t()} | {:error, Ecto.Changeset.t()} | {:error, binary}
  def update_customer(attrs, customer_cpf) do
    case Db.get_customer_by_params(cpf: customer_cpf) do
      [customer] ->
        attrs = CustomerLogic.attrs_for_update(attrs)

        Db.update_customer(customer, attrs)

      [] ->
        {:error, "customer not found"}
    end
  end

  @spec list_all_customers_with_pagination(map) :: map
  def list_all_customers_with_pagination(pagination_data) do
    pagination_data =
      pagination_data
      |> Map.from_struct()
      |> Map.to_list()

    Db.get_all_customers_with_pagination(pagination_data)
  end

  @spec create_billet(map, binary) :: {:ok, Billet.t()} | {:error, Ecto.Changeset.t()}
  def create_billet(attrs, customer_cpf) do
    attrs = BilletLogic.attrs_for_create(attrs)

    Db.insert_billet(attrs, customer_cpf)
  end
end
