defmodule BilletManager.InstallmentsBasis.Services.GetCustomersTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.GetCustomers
  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo

  describe "Get service:" do
    test "list all customers" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      CustomerRepo.insert(attrs)

      assert {:ok, [customer]} = GetCustomers.process()
      assert customer.cpf == attrs.cpf
      assert customer.name == attrs.name
    end
  end
end
