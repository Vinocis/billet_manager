defmodule BilletManagerWeb.V1.CustomerControllerTest do
  use BilletManagerWeb.ConnCase

  alias BilletManager.InstallmentsBasis.Db

  describe "create/2" do
    test "create customer with body params", %{conn: conn} do
      body = %{
        "customer_name" => "Jhon Doe",
        "customer_cpf" => "111.444.777-35"
      }

      conn = post(conn, "/api/v1/customers", body)

      assert response(conn, 200)
    end

    test "fails to create with invalid body", %{conn: conn} do
      body = %{
        "customer_name" => "Jhon Doe",
        "customer_cpf" => "000.000.000-00"
      }

      conn = post(conn, "/api/v1/customers", body)

      assert response(conn, 422)
      errors = json_response(conn, 422)["errors"]

      assert errors == %{
               "detail" => %{"cpf" => ["invalid cpf"]}
             }
    end
  end

  describe "update/2" do
    test "update customer with body params", %{conn: conn} do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      body = %{
        "customer_name" => "Jhon"
      }

      conn = put(conn, "/api/v1/customers/111.444.777-35", body)

      assert response(conn, 200)
    end

    test "fails to update if customer does not exist", %{conn: conn} do
      body = %{
        "customer_name" => "Jhon"
      }

      conn = put(conn, "/api/v1/customers/111.444.777-35", body)

      assert response(conn, 404)
      errors = json_response(conn, 404)["errors"]

      assert errors == %{
               "detail" => "Customer not found"
             }
    end
  end

  describe "index/2" do
    test "list all customers", %{conn: conn} do
      conn = get(conn, "/api/v1/customers")

      assert response(conn, 200)
    end
  end
end
