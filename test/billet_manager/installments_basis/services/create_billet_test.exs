defmodule BilletManager.InstallmentsBasis.Services.CreateBilletTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis.Services.CreateBillet

  @moduletag :integration

  describe "Create service:" do
    test "with valid params, create a billet" do
      customer = insert(:customer)

      attrs =
        :billet
        |> params_for(customer_id: customer.id)
        |> Map.put(:cpf, customer.cpf)

      assert {:ok, billet} = CreateBillet.process(attrs)
      assert billet.code == "code123"
      assert billet.expire_on == ~D[2023-09-02]
      assert billet.status == :opened
      assert billet.value == %Money{amount: 10_000, currency: :BRL}
    end

    test "fails to insert if an obligatory field is missing" do
      insert(:customer)

      attrs =
        :customer
        |> params_for()
        |> Map.delete(:code)

      assert {:error, changeset} = CreateBillet.process(attrs)
      refute changeset.valid?
    end

    test "fails to insert if customer doesn't exists" do
      attrs =
        :customer
        |> params_for()
        |> Map.put(:cpf, "111.444.777-35")

      assert {:error, reason} = CreateBillet.process(attrs)
      assert reason == "Customer not found"
    end
  end
end
