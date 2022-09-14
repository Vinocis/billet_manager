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
end
