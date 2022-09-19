defmodule BilletManagerWeb.Schemas.Billet.PaymentMutationTest do
  use BilletManagerWeb.ConnCase

  @moduletag :integration

  @input %{payment_value: 10_000}

  @billet_payment_mutation """
  mutation($input: BilletPaymentInput!, $code: String!){
    billetPayment(input: $input, code: $code){
      code
      expireOn
      paidValue
      status
      value
    }
  }
  """

  describe "Mutation: billet payment" do
    test "with valid input", %{conn: conn} do
      insert(:billet)

      response =
        post(conn, "/api/v1", %{
          "query" => @billet_payment_mutation,
          "variables" => %{input: @input, code: "code123"}
        })

      assert data = json_response(response, 200)["data"]["billetPayment"]
      assert data["code"] == "code123"
      assert data["expireOn"] == "2023-09-02"
      assert data["paidValue"] == 10_000
      assert data["status"] == "PAID"
      assert data["value"] == 10_000
    end

    test "when billet is already paid", %{conn: conn} do
      insert(:billet, paid_value: 10_000, status: :paid)

      response =
        post(conn, "/api/v1", %{
          "query" => @billet_payment_mutation,
          "variables" => %{input: @input, code: "code123"}
        })

      assert errors = json_response(response, 200)["errors"]

      assert errors == [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "This billet can't receive more payments",
                 "path" => ["billetPayment"]
               }
             ]
    end
  end
end
