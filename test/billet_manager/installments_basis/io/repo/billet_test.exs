defmodule BilletManager.InstallmentsBasis.IO.Repo.BilletTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.IO.Repo.Billet

  @moduletag :integration

  describe "insert/1" do
    test "with valid params" do
      customer = insert(:customer)
      attrs = params_for(:billet, customer_id: customer.id)

      assert {:ok, billet} = Billet.insert(attrs)
      assert billet.code == "code123"
      assert billet.expire_on == ~D[2023-09-02]
      assert billet.status == :opened
      assert billet.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "fails to insert if an obligatory field is missing" do
      attrs =
        :billet
        |> params_for()
        |> Map.delete(:code)

      assert {:error, changeset} = Billet.insert(attrs)
      assert "can't be blank" in errors_on(changeset).code
      assert "can't be blank" in errors_on(changeset).customer_id
      refute changeset.valid?
    end
  end

  describe "get_billets_by_customer_id/1" do
    test "list all billets related to the given customer id" do
      customer = insert(:customer)

      insert(:billet, code: "abc123", customer: customer)
      insert(:billet, code: "def456", customer: customer)

      assert [billet1, billet2] = Billet.get_billets_by_customer_id(customer.id)

      assert billet1.code == "abc123"
      assert billet1.expire_on == ~D[2023-09-02]
      assert billet1.status == :opened
      assert billet1.value == %Money{amount: 10_000, currency: :BRL}

      assert billet2.code == "def456"
      assert billet2.expire_on == ~D[2023-09-02]
      assert billet2.status == :opened
      assert billet2.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "returns an empty list if billets doesn't exists" do
      customer = insert(:customer)

      assert [] = Billet.get_billets_by_customer_id(customer.id)
    end
  end

  describe "update/2" do
    test "with valid params" do
      billet = insert(:billet)

      attrs_for_update = %{status: :partially_paid, paid_value: 1000}

      assert {:ok, updated_billet} = Billet.update(billet, attrs_for_update)
      assert updated_billet.code == "code123"
      assert updated_billet.expire_on == ~D[2023-09-02]
      assert updated_billet.paid_value == %Money{amount: 1000, currency: :BRL}
      assert updated_billet.status == :partially_paid
      assert updated_billet.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "fails with invalid params" do
      billet = insert(:billet)

      attrs_for_update = %{status: :not_paid, paid_value: nil}

      assert {:error, changeset} = Billet.update(billet, attrs_for_update)
      assert "is invalid" in errors_on(changeset).status
      refute changeset.valid?
    end
  end

  describe "fetch_by/1" do
    test "when billet exists" do
      insert(:billet)

      assert {:ok, billet} = Billet.fetch_by(code: "code123")
      assert billet.code == "code123"
      assert billet.expire_on == ~D[2023-09-02]
      assert billet.paid_value == nil
      assert billet.status == :opened
      assert billet.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "when billet does not exists" do
      assert {:error, "Billet not found"} = Billet.fetch_by(code: "code123")
    end
  end
end
