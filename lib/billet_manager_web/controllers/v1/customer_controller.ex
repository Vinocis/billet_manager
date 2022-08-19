defmodule BilletManagerWeb.Controllers.V1.CustomerController do
  @moduledoc """
  Controller that handle customer associated requests
  """
  use BilletManagerWeb, :controller

  alias BilletManager.InstallmentsBasis
  alias BilletManagerWeb.Dto.V1.CustomerRequest
  alias BilletManager.Common.Adapters.Pagination, as: PaginationAdapter

  action_fallback BilletManagerWeb.FallbackController

  @doc """
  List customers with pagination
  """
  def index(conn, params) do
    with {:ok, pagination_data} <-
           PaginationAdapter.params_to_internal_pagination(params),
         %{} = customer_data <-
           InstallmentsBasis.list_customers_with_pagination(pagination_data) do
      render_response(customer_data, conn)
    end
  end

  def create(conn, customer) do
    with {:ok, _} <- create_customer(customer) do
      render_response(:empty, conn)
    end
  end

  def update(conn, %{"cpf" => cpf} = params) do
    with customer <- InstallmentsBasis.get_customer_by_params(cpf: cpf),
         {:ok, _} <- update_customer(params, cpf) do
      render_response(:empty, conn)
    end
  end

  defp create_customer(params) do
    case CustomerRequest.create_changeset(params) do
      {:ok, attrs} ->
        InstallmentsBasis.create_customer(attrs)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp update_customer(params, cpf) do
    params = Map.put(params, "cpf", cpf)

    case CustomerRequest.update_changeset(params) do
      {:ok, attrs} ->
        attrs
        |> Map.delete(:cpf)
        |> InstallmentsBasis.update_customer(cpf)

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
