defmodule BilletManager.InstallmentsBasis.IO.Repo.CustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer

  describe "insert/1" do
    test "with valid params" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      assert {:ok, customer} = Customer.insert(attrs)
      assert customer.cpf == attrs.cpf
      assert customer.name == attrs.name
    end

    test "fails to insert if an obligatory field is missing" do
      attrs = %{
        name: "Jhon Doe"
      }

      assert {:error, changeset} = Customer.insert(attrs)
      refute changeset.valid?
    end
  end

  describe "update/2" do
    test "with valid params" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      attrs_for_update = %{name: "Tom"}

      {:ok, customer} = Customer.insert(attrs)

      assert {:ok, updated_customer} = Customer.update(attrs_for_update, customer)
      assert updated_customer.name == "Tom"
      refute updated_customer.name == customer.name
    end

    test "fails with invalid params" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      attrs_for_update = %{name: :Tom}

      {:ok, customer} = Customer.insert(attrs)

      assert {:error, changeset} = Customer.update(attrs_for_update, customer)
      refute changeset.valid?
    end
  end

  describe "all/0" do
    test "list all customers" do
      attrs = %{
        cpf: "111.444.777-35",
        name: "Jhon Doe"
      }

      Customer.insert(attrs)

      assert [customer] = Customer.all()
      assert customer.cpf == attrs.cpf
      assert customer.name == attrs.name
    end
  end
end
