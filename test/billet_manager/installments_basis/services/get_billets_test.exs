defmodule BilletManager.InstallmentsBasis.Services.GetBilletsTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.GetBillets

  @moduletag :integration

  describe "Get service:" do
    test "list all billets of the respective customer" do
      customer = insert(:customer)

      insert(:billet, code: "abc123", customer: customer)
      insert(:billet, code: "def456", customer: customer)

      assert {:ok, [billet1, billet2]} = GetBillets.process(%{cpf: "111.444.777-35"})

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
      insert(:customer)

      assert {:ok, []} = GetBillets.process(%{cpf: "111.444.777-35"})
    end
  end
end
