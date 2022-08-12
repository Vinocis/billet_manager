defmodule BilletManager.InstallmentsBasis.Db do
  alias BilletManager.InstallmentsBasis.Models.Billet
  alias BilletManager.InstallmentsBasis.Models.Customer
  alias BilletManager.InstallmentsBasis.Pagination
  alias BilletManager.InstallmentsBasis.Queries.Customer, as: CustomerQueries
  alias BilletManager.InstallmentsBasis.Queries.Billet, as: BilletQueries
  alias BilletManager.Repo

  def insert_customer(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  def update_customer(customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  def insert_billet(attrs, customer_cpf) do
    case get_customer_by_params(cpf: customer_cpf) do
      [customer] ->
        customer
        |> Ecto.build_assoc(:billets)
        |> Billet.changeset(attrs)
        |> Repo.insert()

      [] ->
        {:error, "customer not found"}
    end
  end

  def get_customer_by_params(params) do
    params
    |> CustomerQueries.get_customers()
    |> Repo.all()
  end

  def get_all_customers_with_pagination(pagination_data) do
    CustomerQueries.get_all_customers()
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

  def get_billets_by_params(params) do
    params
    |> BilletQueries.get_billets()
    |> Repo.all()
  end

  def changeset_errors_to_string(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {message, _}} -> "#{field}: #{message}\n" end)
    |> List.to_string()
  end
end
