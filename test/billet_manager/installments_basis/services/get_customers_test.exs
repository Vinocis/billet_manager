defmodule BilletManager.InstallmentsBasis.Services.GetCustomersTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.GetCustomers

  @moduletag :integration

  describe "Get service:" do
    test "list all customers" do
      insert(:customer, name: "Jhon", cpf: "907.109.000-07")
      insert(:customer, name: "Tom", cpf: "111.444.777-35")

      assert {:ok, [customer1, customer2]} = GetCustomers.process()

      assert customer1.name == "Jhon"
      assert customer1.cpf == "907.109.000-07"

      assert customer2.name == "Tom"
      assert customer2.cpf == "111.444.777-35"
    end

    test "returns an empty list if customers doesn't exists" do
      assert {:ok, []} == GetCustomers.process()
    end
  end
end
