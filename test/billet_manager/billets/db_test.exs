defmodule BilletManager.Billets.DbTest do
  use BilletManager.DataCase

  alias BilletManager.Billets.Db

  setup do
    payload = %{
      name: "Vinicius",
      cpf: "111.444.777-35",
      code: "cod14135",
      value: 111,
      status: :opened,
      expire_on: ~N[2022-10-03 14:08:48]
    }

    {:ok, %{payload: payload}}
  end

  describe "get_customer_by_params/1" do
    test "returns a empty list if entity doesn't exist" do
      assert [] == Db.get_customer_by_params([])
    end

    test "returns a list with entities if exists", %{payload: payload} do
      Db.maybe_insert_customer(payload)

      [customer] = Db.get_customer_by_params(cpf: payload.cpf)

      assert customer.cpf == payload.cpf
      assert customer.name == payload.name
    end
  end

  describe "get_billets_by_params/1" do
    test "returns a empty list if entity doesn't exist" do
      assert [] == Db.get_billets_by_params([])
    end

    test "returns a list with entities if exists", %{payload: payload} do
      Db.maybe_insert_customer(payload)
      Db.insert_or_update_billet(payload)

      [billet] = Db.get_billets_by_params(code: payload.code)

      assert billet.code == payload.code
    end
  end

  describe "maybe_insert_customer/1" do
    test "insert customer with valid params", %{payload: payload} do
      assert {:ok, _} = Db.maybe_insert_customer(payload)
    end

    test "fails to insert customer with invalid params", %{payload: payload} do
      payload1 = %{payload | name: 1}
      payload2 = Map.delete(payload, :name)

      assert {:error, _} = Db.maybe_insert_customer(payload1)
      assert {:error, _} = Db.maybe_insert_customer(payload2)
    end
  end

  describe "insert_or_update_billet/1" do
    test "insert with valid params when customer exists", %{payload: payload} do
      Db.maybe_insert_customer(payload)

      assert {:ok, _} = Db.insert_or_update_billet(payload)
    end

    test "update with valid params when customer exists", %{payload: payload} do
      new_billet = %{payload | status: :expired}
      Db.maybe_insert_customer(payload)
      Db.insert_or_update_billet(payload)

      assert {:ok, billet} = Db.insert_or_update_billet(new_billet)
      assert billet.code == payload.code
      refute billet.status == payload.status
    end

    test "fails with valid params but customer doesn't exists", %{payload: payload} do
      assert {:error, _} = Db.insert_or_update_billet(payload)
    end
  end

  describe "insert_customer_and_billet/1" do
    test "insert both with valid params", %{payload: payload} do
      assert {:ok, _} = Db.insert_customer_and_billet(payload)
    end

    test "fails and don't insert if billet is invalid", %{payload: payload} do
      invalid_billet = %{payload | status: :invalid}

      assert {:error, _, _, _} = Db.insert_customer_and_billet(invalid_billet)
      assert [] == Db.get_billets_by_params(code: payload.code)
      assert [] == Db.get_customer_by_params(cpf: payload.cpf)
    end

    test "fails and don't insert if customer is invalid", %{payload: payload} do
      invalid_customer = %{payload | name: :Vinicius}

      assert {:error, _, _, _} = Db.insert_customer_and_billet(invalid_customer)
      assert [] == Db.get_customer_by_params(cpf: payload.cpf)
      assert [] == Db.get_billets_by_params(code: payload.code)
    end

    test "if both exists, update the billet", %{payload: payload} do
      {:ok, customer} = Db.maybe_insert_customer(payload)
      {:ok, billet} = Db.insert_or_update_billet(payload)

      assert customer.cpf == payload.cpf

      assert billet.code == payload.code
      assert billet.value.amount == payload.value
      assert billet.status == payload.status

      updated_billet = %{
        payload
        | value: 200,
          status: :expired
      }

      assert {:ok, _} = Db.insert_customer_and_billet(updated_billet)
      assert customer.cpf == payload.cpf

      assert updated_billet.code == billet.code
      refute updated_billet.value == billet.value
      refute updated_billet.status == billet.status
    end
  end
end
