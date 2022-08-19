defmodule BilletManagerWeb.Controllers.V1.BilletController do
  use BilletManagerWeb, :controller

  alias BilletManager.InstallmentsBasis
  alias BilletManagerWeb.Dto.V1.CreateBillet

  action_fallback BilletManagerWeb.FallbackController

  def create(conn, %{"cpf" => cpf} = params) do
    with %{id: id} <-
           InstallmentsBasis.get_customer_by_params(cpf: cpf),
         {:ok, _billet} <- create_billet(params, id) do
      render_response(:empty, conn)
    end
  end

  defp create_billet(params, id) do
    result =
      params
      |> Map.put("customer_id", id)
      |> CreateBillet.changeset()

    case result do
      {:ok, attrs} ->
        InstallmentsBasis.create_billet(attrs)

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
