defmodule BilletManagerWeb.FallbackController do
  @moduledoc false
  use BilletManagerWeb, :controller

  alias BilletManagerWeb.ErrorView

  @finding_errors ~w(
    customer_not_found
    not_found
    )a

  @type conn :: Plug.Conn.t()

  @spec call(conn, any) :: conn
  def call(conn, nil) do
    call(conn, {:error, :not_found})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, %Ecto.Changeset{} = changeset) do
    call(conn, {:error, changeset})
  end

  def call(conn, {:error, error}) when error in @finding_errors do
    reason =
      case error do
        :customer_not_found -> gettext("Customer not found")
        :not_found -> gettext("The item you requested doesn't exist")
      end

    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
