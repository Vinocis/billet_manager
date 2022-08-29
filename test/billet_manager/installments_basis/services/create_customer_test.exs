defmodule BilletManager.InstallmentsBasis.Services.CreateCustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.CreateCustomer

  describe "Create service:" do
    test "with valid params, create a customer" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      assert {:ok, customer} = CreateCustomer.process(attrs)
      assert customer.cpf == attrs.cpf
      assert customer.name == attrs.name
    end

    test "fails to insert if an obligatory field is missing" do
      attrs = %{
        name: "Jhon Doe"
      }

      assert {:error, changeset} = CreateCustomer.process(attrs)
      refute changeset.valid?
    end
  end
end
