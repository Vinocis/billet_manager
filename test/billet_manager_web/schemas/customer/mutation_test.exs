defmodule BilletManagerWeb.Schemas.Customer.MutationTest do
  use BilletManagerWeb.ConnCase

  @moduletag :integration

  @variables %{
    cpf: "111.444.777-35",
    name: "Jhon Doe"
  }

  @create_customer_mutation """
  mutation($input: CreateCustomerInput!){
    createCustomer(input: $input){
      cpf
      name
    }
  }
  """

  @update_customer_mutation """
  mutation($input: UpdateCustomerInput!, $cpf: String!){
    updateCustomer(input: $input, cpf: $cpf){
      name
    }
  }
  """

  describe "Mutation: create customer" do
    test "with valid input", %{conn: conn} do
      response =
        post(conn, "/api/v1", %{
          "query" => @create_customer_mutation,
          "variables" => %{input: @variables}
        })

      assert data = json_response(response, 200)["data"]["createCustomer"]
      assert data["cpf"] == @variables.cpf
      assert data["name"] == @variables.name
    end

    test "fails if input doesn't have obligatory fields", %{conn: conn} do
      variables = Map.delete(@variables, :cpf)

      response =
        post(conn, "/api/v1", %{
          "query" => @create_customer_mutation,
          "variables" => %{input: variables}
        })

      assert errors = json_response(response, 200)["errors"]

      assert errors ==
               [
                 %{
                   "locations" => [%{"column" => 18, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"cpf\": Expected type \"String!\", found null."
                 }
               ]
    end
  end

  describe "Mutation: update customer" do
    test "with valid input", %{conn: conn} do
      insert(:customer)

      response =
        post(conn, "/api/v1", %{
          "query" => @update_customer_mutation,
          "variables" => %{input: %{name: "Tom"}, cpf: "111.444.777-35"}
        })

      assert data = json_response(response, 200)["data"]["updateCustomer"]
      assert data["name"] == "Tom"
    end

    test "fails if customer doesn't exists", %{conn: conn} do
      response =
        post(conn, "/api/v1", %{
          "query" => @update_customer_mutation,
          "variables" => %{input: %{name: "Tom"}, cpf: "111.444.777-35"}
        })

      assert errors = json_response(response, 200)["errors"]

      assert errors ==
               [
                 %{
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "Customer not found",
                   "path" => ["updateCustomer"]
                 }
               ]
    end
  end
end
