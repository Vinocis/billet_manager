defmodule BilletManager.InstallmentsBasis.IO.Repo.CustomerTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer

  @moduletag :integration

  describe "insert/1" do
    test "with valid params" do
      attrs = params_for(:customer)

      assert {:ok, customer} = Customer.insert(attrs)
      assert customer.cpf == "111.444.777-35"
      assert customer.name == "Jhon Doe"
    end

    test "fails to insert if an obligatory field is missing" do
      attrs =
        :customer
        |> params_for()
        |> Map.delete(:cpf)

      assert {:error, changeset} = Customer.insert(attrs)
      refute changeset.valid?
    end
  end

  describe "update/2" do
    test "with valid params" do
      customer = insert(:customer)

      attrs_for_update = %{name: "Tom"}

      assert {:ok, updated_customer} = Customer.update(customer, attrs_for_update)
      assert updated_customer.name == "Tom"
      refute updated_customer.name == "Jhon Doe"
    end

    test "fails with invalid params" do
      customer = insert(:customer)

      attrs_for_update = %{name: :Tom}

      assert {:error, changeset} = Customer.update(customer, attrs_for_update)
      refute changeset.valid?
    end
  end

  describe "all/0" do
    test "list all customers" do
      insert(:customer, name: "Jhon", cpf: "907.109.000-07")
      insert(:customer, name: "Tom", cpf: "111.444.777-35")

      refute [] == Customer.all()
    end
  end
end
