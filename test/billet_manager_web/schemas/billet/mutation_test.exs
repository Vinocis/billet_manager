defmodule BilletManagerWeb.Schemas.Billet.MutationTest do
  use BilletManagerWeb.ConnCase

  @moduletag :integration

  @input params_for(
           :billet,
           expire_on: "2023-09-02",
           status: "OPENED"
         )

  @create_billet_mutation """
  mutation($input: BilletInput!, $cpf: String!){
    createBillet(input: $input, cpf: $cpf){
      value
      code
      status
      expireOn
    }
  }
  """

  describe "Mutation: create billet" do
    test "with valid input", %{conn: conn} do
      customer = insert(:customer)

      response =
        post(conn, "/api/v1", %{
          "query" => @create_billet_mutation,
          "variables" => %{input: @input, cpf: customer.cpf}
        })

      assert data = json_response(response, 200)["data"]["createBillet"]
      assert data["code"] == "code123"
      assert data["expireOn"] == "2023-09-02"
      assert data["status"] == "OPENED"
      assert data["value"] == 10_000
    end

    test "fails if customer doesn't exists", %{conn: conn} do
      response =
        post(conn, "/api/v1", %{
          "query" => @create_billet_mutation,
          "variables" => %{input: @input, cpf: "111.444.777-35"}
        })

      assert errors = json_response(response, 200)["errors"]

      assert errors ==
               [
                 %{
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "Customer not found",
                   "path" => ["createBillet"]
                 }
               ]
    end

    test "fails if input doesn't have obligatory fields", %{conn: conn} do
      customer = insert(:customer)
      input = Map.delete(@input, :code)

      response =
        post(conn, "/api/v1", %{
          "query" => @create_billet_mutation,
          "variables" => %{input: input, cpf: customer.cpf}
        })

      assert errors = json_response(response, 200)["errors"]

      assert errors ==
               [
                 %{
                   "locations" => [%{"column" => 16, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"code\": Expected type \"String!\", found null."
                 }
               ]
    end
  end
end
