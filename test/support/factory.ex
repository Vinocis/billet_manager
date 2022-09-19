defmodule BilletManager.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: BilletManager.Repo

  alias BilletManager.InstallmentsBasis.Models.Billet
  alias BilletManager.InstallmentsBasis.Models.Customer

  def customer_factory do
    %Customer{
      cpf: "111.444.777-35",
      name: "Jhon Doe"
    }
  end

  def billet_factory do
    %Billet{
      code: "code123",
      expire_on: ~D[2023-09-02],
      paid_value: nil,
      status: :opened,
      value: 10_000,
      customer: build(:customer)
    }
  end
end
