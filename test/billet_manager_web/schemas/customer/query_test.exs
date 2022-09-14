defmodule BilletManagerWeb.Schemas.Customer.QueryTest do
  use BilletManagerWeb.ConnCase

  @moduletag :integration

  @query """
  query{
    customers{
      name
      cpf
    }
  }
  """

  test "list all customers", %{conn: conn} do
    insert(:customer)

    response = post(conn, "/api/v1", %{"query" => @query})

    assert [data] = json_response(response, 200)["data"]["customers"]

    assert data["cpf"] == "111.444.777-35"
    assert data["name"] == "Jhon Doe"
  end
end
