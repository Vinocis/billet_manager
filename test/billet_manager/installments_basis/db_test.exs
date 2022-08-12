defmodule BilletManager.InstallmentsBasis.DbTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Db

  describe "get_customer_by_params/1" do
    test "returns a empty list if entity doesn't exist" do
      assert [] == Db.get_customer_by_params([])
    end

    test "returns a list with entities if exists" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}

      Db.insert_customer(customer)

      [inserted_customer] = Db.get_customer_by_params(cpf: customer.cpf)

      assert inserted_customer.cpf == customer.cpf
      assert inserted_customer.name == customer.name
    end
  end

  describe "get_billets_by_params/1" do
    test "returns a empty list if entity doesn't exist" do
      assert [] == Db.get_billets_by_params([])
    end

    test "returns a list with entities if exists" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}

      billet = %{
        code: "11111.11111 11111.11111",
        value: 250,
        expire_on: ~N[2022-10-03 14:08:48]
      }

      Db.insert_customer(customer)
      Db.insert_billet(billet, customer.cpf)

      [inserted_billet] = Db.get_billets_by_params(code: billet.code)

      assert inserted_billet.code == billet.code
    end
  end

  describe "insert_customer/1" do
    test "insert customer with valid params" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}

      assert {:ok, _} = Db.insert_customer(customer)
    end

    test "fails to insert customer with invalid params" do
      customer1 = %{cpf: "111.444.777-35", name: 1}
      customer2 = Map.delete(customer1, :name)

      assert {:error, _} = Db.insert_customer(customer1)
      assert {:error, _} = Db.insert_customer(customer2)
    end
  end

  describe "update_customer/2" do
    test "update customer with valid params" do
      attrs = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      {:ok, customer} = Db.insert_customer(attrs)

      assert {:ok, _} = Db.update_customer(customer, %{name: "Tom"})
    end

    test "fails to update customer with invalid params" do
      attrs = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      {:ok, customer} = Db.insert_customer(attrs)

      assert {:error, _} = Db.update_customer(customer, %{name: nil})
    end
  end

  describe "insert_billet/1" do
    test "insert with valid params when customer exists" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}

      billet = %{
        code: "11111.11111 11111.11111",
        value: 250,
        expire_on: ~N[2022-10-03 14:08:48]
      }

      Db.insert_customer(customer)

      assert {:ok, _} = Db.insert_billet(billet, customer.cpf)
    end

    test "fails with valid params but customer doesn't exists" do
      billet = %{
        code: "11111.11111 11111.11111",
        value: 250,
        expire_on: ~N[2022-10-03 14:08:48]
      }

      assert {:error, error} = Db.insert_billet(billet, "111.444.777-35")
      assert error == "customer not found"
    end
  end
end
