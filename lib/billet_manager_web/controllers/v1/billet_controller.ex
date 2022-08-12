defmodule BilletManagerWeb.Controllers.V1.BilletController do
  use BilletManagerWeb, :controller

  alias BilletManager.InstallmentsBasis
  alias BilletManager.InstallmentsBasis.Db

  def create(conn, %{"cpf" => cpf} = params) do
    case InstallmentsBasis.create_billet(params, cpf) do
      {:ok, _} ->
        send_resp(conn, 200, "Billet created!")

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Db.changeset_errors_to_string(changeset)

        send_resp(conn, 400, "#{errors}")

      {:error, error} ->
        send_resp(conn, 400, error)
    end
  end
end
