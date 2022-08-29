defmodule BilletManager.InstallmentsBasis.Services.UpdateCustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.UpdateCustomer
  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo

  describe "Update service:" do
    test "with valid params, update a customer" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      attrs_for_update = %{
        cpf: attrs.cpf,
        name: "Tom"
      }

      CustomerRepo.insert(attrs)

      assert {:ok, updated_customer} = UpdateCustomer.process(attrs_for_update)
      assert updated_customer.name == "Tom"
      refute updated_customer.name == attrs.name
    end

    test "fails to update if the customer doesn't exists" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      attrs_for_update = %{
        cpf: "983.016.120-02",
        name: "Tom"
      }

      CustomerRepo.insert(attrs)

      assert {:error, error} = UpdateCustomer.process(attrs_for_update)
      assert error == "Customer not found"
    end

    test "fails to update with invalid params" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      attrs_for_update = %{
        cpf: attrs.cpf,
        name: :Tom
      }

      CustomerRepo.insert(attrs)

      assert {:error, changeset} = UpdateCustomer.process(attrs_for_update)
      refute changeset.valid?
    end
  end
end
