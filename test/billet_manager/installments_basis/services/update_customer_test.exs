defmodule BilletManager.InstallmentsBasis.Services.UpdateCustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.UpdateCustomer

  @moduletag :integration

  describe "Update service:" do
    test "with valid params, update a customer" do
      insert(:customer)

      attrs_for_update = params_for(:customer, name: "Tom")

      assert {:ok, updated_customer} = UpdateCustomer.process(attrs_for_update)
      assert updated_customer.name == "Tom"
    end

    test "fails to update if the customer doesn't exists" do
      insert(:customer)

      attrs_for_update =
        params_for(
          :customer,
          cpf: "983.016.120-02",
          name: "Tom"
        )

      assert {:error, error} = UpdateCustomer.process(attrs_for_update)
      assert error == "Customer not found"
    end

    test "fails to update with invalid params" do
      insert(:customer)

      attrs_for_update = params_for(:customer, name: :Tom)

      assert {:error, changeset} = UpdateCustomer.process(attrs_for_update)
      assert "is invalid" in errors_on(changeset).name
      refute changeset.valid?
    end
  end
end
