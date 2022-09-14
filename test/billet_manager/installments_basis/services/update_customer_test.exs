defmodule BilletManager.InstallmentsBasis.Services.UpdateCustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.UpdateCustomer

  @moduletag :integration

  describe "Update service:" do
    test "with valid params, update a customer" do
      insert(:customer)

      attrs = params_for(:customer, name: "Tom")

      assert {:ok, customer} = UpdateCustomer.process(%{cpf: "111.444.777-35", input: attrs})

      assert customer.name == "Tom"
      assert customer.cpf == "111.444.777-35"
    end

    test "fails to update if the customer doesn't exists" do
      insert(:customer)

      attrs =
        params_for(
          :customer,
          name: "Tom"
        )

      assert {:error, error} = UpdateCustomer.process(%{cpf: "983.016.120-02", input: attrs})
      assert error == "Customer not found"
    end

    test "fails to update with invalid params" do
      insert(:customer)

      attrs = params_for(:customer, name: :Tom)

      assert {:error, changeset} = UpdateCustomer.process(%{cpf: "111.444.777-35", input: attrs})
      assert "is invalid" in errors_on(changeset).name
      refute changeset.valid?
    end
  end
end
