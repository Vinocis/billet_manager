defmodule BilletManagerWeb.Schemas.Customer.BilletsQueryTest do
  use BilletManagerWeb.ConnCase

  @moduletag :integration

  @query """
  query{
    customers{
      name
      cpf
      billets {
        code
        expireOn
        status
        value
      }
    }
  }
  """

  test "list all customers with billets", %{conn: conn} do
    customer = insert(:customer)

    insert(:billet, code: "abc123", customer: customer)
    insert(:billet, code: "def456", customer: customer)

    response = post(conn, "/api/v1", %{"query" => @query})

    assert [data] = json_response(response, 200)["data"]["customers"]

    assert data["cpf"] == "111.444.777-35"
    assert data["name"] == "Jhon Doe"

    assert data["billets"] == [
             %{
               "code" => "abc123",
               "expireOn" => "2023-09-02",
               "status" => "OPENED",
               "value" => 10_000
             },
             %{
               "code" => "def456",
               "expireOn" => "2023-09-02",
               "status" => "OPENED",
               "value" => 10_000
             }
           ]
  end
end
