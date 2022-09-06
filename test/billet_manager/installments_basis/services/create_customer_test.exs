defmodule BilletManager.InstallmentsBasis.Services.CreateCustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.CreateCustomer

  @moduletag :integration

  describe "Create service:" do
    test "with valid params, create a customer" do
      attrs = params_for(:customer)

      assert {:ok, customer} = CreateCustomer.process(attrs)
      assert customer.cpf == attrs.cpf
      assert customer.name == attrs.name
    end

    test "fails to insert if an obligatory field is missing" do
      attrs =
        :customer
        |> params_for()
        |> Map.delete(:cpf)

      assert {:error, changeset} = CreateCustomer.process(attrs)
      assert "can't be blank" in errors_on(changeset).cpf
      refute changeset.valid?
    end
  end
end
