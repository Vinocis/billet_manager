defmodule BilletManager.InstallmentsBasis.IO.Repo.BilletTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.IO.Repo.Billet

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
        :customer
        |> params_for()
        |> Map.delete(:code)

      assert {:error, changeset} = Billet.insert(attrs)
      refute changeset.valid?
    end
  end
end
