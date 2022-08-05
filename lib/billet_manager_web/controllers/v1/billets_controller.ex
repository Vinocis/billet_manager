defmodule BilletManagerWeb.Controllers.V1.BilletsController do
  use BilletManagerWeb, :controller

  alias BilletManager.Billets
  alias BilletManager.Billets.Db

  def create(conn, payload) do
    case Billets.create_customer_and_billet(payload) do
      {:ok, _multi} ->
        send_resp(conn, 200, "Success!")

      {:error, failed_op, changeset, _} ->
        errors = Db.changeset_errors_to_string(changeset)

        send_resp(conn, 400, "Failed at #{failed_op} table.\n#{errors}")
    end
  end
end
