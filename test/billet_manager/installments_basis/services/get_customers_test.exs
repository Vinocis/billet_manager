defmodule BilletManager.InstallmentsBasis.Services.GetCustomersTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.GetCustomers

  @moduletag :integration

  describe "Get service:" do
    test "list all customers" do
      insert(:customer, name: "Jhon", cpf: "907.109.000-07")
      insert(:customer, name: "Tom", cpf: "111.444.777-35")

      refute {:ok, []} == GetCustomers.process()
      assert {:ok, [_customer1, _customer2]} = GetCustomers.process()
    end
  end
end
