defmodule BilletManager.Billets.BilletsTest do
  use BilletManager.DataCase

  alias BilletManager.Billets
  alias BilletManager.Billets.Models.Billet
  alias BilletManager.Billets.Models.Customer
  alias BilletManager.Billets.Db

  describe "create_customer_and_billet/1" do
    test "success with valid params" do
      payload = %{
        "customer_name" => "Vinicius",
        "customer_cpf" => "111.444.777-35",
        "billet_code" => "cod14135",
        "billet_value" => 111,
        "billet_status" => "opened",
        "billet_expire_on" => "2022-10-03T14:08:48-03:00"
      }

      assert {:ok, _} = Billets.create_customer_and_billet(payload)
      [%Billet{code: code}] = Db.get_billets_by_params(code: payload["billet_code"])
      [%Customer{cpf: cpf}] = Db.get_customer_by_params(cpf: payload["customer_cpf"])

      assert code == payload["billet_code"]
      assert cpf == payload["customer_cpf"]
    end

    test "fails with invalid params" do
      payload = %{
        "customer_name" => "Vinicius",
        "customer_cpf" => "011.444.777-35",
        "billet_code" => "cod14135",
        "billet_value" => 0,
        "billet_status" => "invalid",
        "billet_expire_on" => "2022-08-03T14:08:48-03:00"
      }

      assert {:error, _, _, _} = Billets.create_customer_and_billet(payload)
    end
  end
end
