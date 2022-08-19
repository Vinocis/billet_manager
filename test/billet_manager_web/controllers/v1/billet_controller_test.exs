defmodule BilletManagerWeb.Controllers.V1.BilletControllerTest do
  use BilletManagerWeb.ConnCase

  alias BilletManager.InstallmentsBasis.Db

  describe "create/2" do
    test "create billet with body params", %{conn: conn} do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      body = %{
        "billet_code" => "cod14135",
        "billet_value" => 111,
        "billet_expire_on" => "2022-10-03T14:08:48-03:00"
      }

      conn = post(conn, "/api/v1/customers/111.444.777-35/bank-billets", body)

      assert response(conn, 200)
    end

    test "fails to create with invalid body when customer exists", %{conn: conn} do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      body = %{
        "billet_code" => "cod14135",
        "billet_expire_on" => "2022-08-03T14:08:48-03:00"
      }

      conn = post(conn, "/api/v1/customers/111.444.777-35/bank-billets", body)

      assert response(conn, 422)
      errors = json_response(conn, 422)["errors"]

      assert errors == %{
               "detail" => %{"value" => ["can't be blank"]}
             }
    end
  end
end
