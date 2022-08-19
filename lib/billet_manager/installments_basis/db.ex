defmodule BilletManager.InstallmentsBasis.Db do
  @moduledoc """
  Database interaction module 
  """

  alias BilletManager.InstallmentsBasis.Models.Billet
  alias BilletManager.InstallmentsBasis.Models.Customer
  alias BilletManager.Common.Pagination
  alias BilletManager.InstallmentsBasis.Queries.Customer, as: CustomerQueries
  alias BilletManager.InstallmentsBasis.Queries.Billet, as: BilletQueries
  alias BilletManager.Repo

  @doc """
  Insert a customer on the database.
  """
  @spec insert_customer(map) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def insert_customer(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer. 
  """
  @spec update_customer(Customer.t(), map) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def update_customer(customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Insert a bank-billet on the database. If the given cpf
  customer doesn't existis, return a error tuple.
  """
  @spec insert_billet(map) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t() | atom}
  def insert_billet(attrs) do
    if Map.get(attrs, :customer_id) do
      case get_customer_by_params(id: attrs.customer_id) do
        nil ->
          {:error, :customer_not_found}

        customer ->
          customer
          |> Ecto.build_assoc(:billets)
          |> Billet.changeset(attrs)
          |> Repo.insert()
      end
    else
      {:error, :customer_not_found}
    end
  end

  @doc """
  Makes a query in the database with the given params
  to fetch customers.
  """
  @spec get_customer_by_params(keyword) :: Ecto.Schema.t() | nil
  def get_customer_by_params(params) do
    params
    |> CustomerQueries.get_customers_by()
    |> Repo.one()
  end

  @doc """
  Build a map with the customers and pagination data. The
  pagination begins is the page 1.

  ## Example

      iex> Common.Pagination.paginate(query, page: 1, page_size: 10)
      %{
        page_number: 1,
        page_size: 10,
        total_entries: 1
        total_pages: 1,
        entries: [
          %{
            cpf: "111.444.777-45",
            name: "Jhon Doe"
          }
        ]
      }
  """
  @spec get_customers_with_pagination(keyword) :: map
  def get_customers_with_pagination(pagination_data) do
    CustomerQueries.get_customers()
    |> Pagination.paginate(pagination_data)
    |> build_customer_data()
  end

  defp build_customer_data(%{entries: entries} = pagination_data) do
    new_entries = Enum.map(entries, &map_customer_data/1)

    %{pagination_data | entries: new_entries}
  end

  defp map_customer_data(customer) do
    %{
      cpf: customer.cpf,
      name: customer.name
    }
  end

  @doc """
  Makes a query in the database with the given params
  to fetch bank billets.
  """
  @spec get_billets_by_params(keyword) :: list
  def get_billets_by_params(params) do
    params
    |> BilletQueries.get_billets_by()
    |> Repo.all()
  end
end
