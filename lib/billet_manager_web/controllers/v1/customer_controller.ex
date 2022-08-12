defmodule BilletManagerWeb.Controllers.V1.CustomerController do
  use BilletManagerWeb, :controller

  alias BilletManager.InstallmentsBasis
  alias BilletManager.InstallmentsBasis.Db
  alias BilletManager.InstallmentsBasis.Adapters.Pagination, as: PaginationAdapter
  alias BilletManagerWeb.BaseView

  def create(conn, customer) do
    case InstallmentsBasis.create_customer(customer) do
      {:ok, _} ->
        send_resp(conn, 200, "Customer created!")

      {:error, changeset} ->
        errors = Db.changeset_errors_to_string(changeset)

        send_resp(conn, 400, "#{errors}")
    end
  end

  def update(conn, %{"cpf" => cpf} = params) do
    case InstallmentsBasis.update_customer(params, cpf) do
      {:ok, _} ->
        send_resp(conn, 200, "Customer updated!")

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Db.changeset_errors_to_string(changeset)

        send_resp(conn, 400, "#{errors}")

      {:error, error} ->
        send_resp(conn, 400, error)
    end
  end

  def index(conn, params) do
    {:ok, pagination_data} = PaginationAdapter.params_to_internal_pagination(params)
    customer_data = InstallmentsBasis.list_all_customers_with_pagination(pagination_data)

    conn
    |> put_view(BaseView)
    |> render("response.json", data: customer_data)
  end
end
