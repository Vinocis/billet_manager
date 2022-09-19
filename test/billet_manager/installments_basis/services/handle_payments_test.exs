defmodule BilletManager.InstallmentsBasis.Services.HandlePaymentsTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.HandlePayments

  @moduletag :integration

  describe "Payment service:" do
    test "when payment value is lesser than billet value" do
      insert(:billet)

      attrs = %{payment_value: 1000}

      assert {:ok, updated_billet} = HandlePayments.process(%{code: "code123", input: attrs})
      assert updated_billet.status == :partially_paid
      assert updated_billet.code == "code123"
      assert updated_billet.expire_on == ~D[2023-09-02]
      assert updated_billet.paid_value == %Money{amount: 1000, currency: :BRL}
      assert updated_billet.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "when payment value is the same or greater than billet value" do
      insert(:billet)

      attrs = %{payment_value: 10_000}

      assert {:ok, updated_billet} = HandlePayments.process(%{code: "code123", input: attrs})
      assert updated_billet.status == :paid
      assert updated_billet.code == "code123"
      assert updated_billet.expire_on == ~D[2023-09-02]
      assert updated_billet.paid_value == %Money{amount: 10_000, currency: :BRL}
      assert updated_billet.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "when billet is already paid" do
      insert(:billet, paid_value: 10_000, status: :paid)

      attrs = %{payment_value: 10_000}

      assert {:error, error} = HandlePayments.process(%{code: "code123", input: attrs})
      assert error == "This billet can't receive more payments"
    end
  end
end
