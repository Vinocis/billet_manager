defmodule BilletManagerWeb.Schemas.Customer.QueryTest do
  use BilletManagerWeb.ConnCase

  alias BilletManager.InstallmentsBasis.Services.CreateCustomer

  @moduletag :integration

  @query """
  query{
    customers{
      name
      cpf
    }
  }
  """

  describe "Customers query" do
    test "list all customers", %{conn: conn} do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      CreateCustomer.process(attrs)

      response = post(conn, "/api/v1", %{"query" => @query})

      assert [data | _tail] = json_response(response, 200)["data"]["customers"]

      assert data["cpf"] == attrs.cpf
      assert data["name"] == attrs.name
    end
  end
end
