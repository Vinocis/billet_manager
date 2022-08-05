defmodule BilletManagerWeb.Controllers.V1.BilletsControllerTest do
  use BilletManagerWeb.ConnCase

  describe "create/2" do
    test "create customer and billet", %{conn: conn} do
      body = %{
        "customer_name" => "Vinicius",
        "customer_cpf" => "111.444.777-35",
        "billet_code" => "cod14135",
        "billet_value" => 111,
        "billet_status" => "opened",
        "billet_expire_on" => "2022-10-03T14:08:48-03:00"
      }

      conn = post(conn, "/api/v1/bank-billets", body)

      assert response(conn, 200)
      assert conn.resp_body == "Success!"
    end

    test "fails to create with invalid body", %{conn: conn} do
      body = %{
        "customer_name" => "Vinicius",
        "customer_cpf" => "111.444.777-35",
        "billet_code" => "cod14135",
        "billet_value" => nil,
        "billet_status" => "opened",
        "billet_expire_on" => "2022-08-03T14:08:48-03:00"
      }

      conn = post(conn, "/api/v1/bank-billets", body)

      assert response(conn, 400)
      refute conn.resp_body == "Success!"
    end
  end
end

