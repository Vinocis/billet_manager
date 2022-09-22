defmodule BilletManagerWeb.Schemas.Billet.Resolver do
  @moduledoc false

  alias BilletManager.InstallmentsBasis.Services.ConsolidatePayment
  alias BilletManager.InstallmentsBasis.Services.CreateBillet
  alias BilletManager.InstallmentsBasis.Services.GetBillets

  def create_billet(_parent, %{cpf: _cpf, input: _input} = params, _context) do
    with {:ok, billet} <- CreateBillet.process(params) do
      {:ok, transform(billet)}
    end
  end

  def get_billets(parent, _params, _context) do
    with {:ok, billets} <- GetBillets.process(parent) do
      {:ok, transform(billets)}
    end
  end

  def handle_payments(_parent, params, _context) do
    with {:ok, billet} <- ConsolidatePayment.process(params) do
      {:ok, transform(billet)}
    end
  end

  defp transform([]), do: []

  defp transform([%{} | _rest] = billets) do
    Enum.map(billets, &%{&1 | value: &1.value.amount})
  end

  defp transform(%{paid_value: nil, value: _} = billet) do
    Map.update!(billet, :value, &Map.get(&1, :amount))
  end

  defp transform(%{paid_value: _, value: _} = billet) do
    billet
    |> Map.update!(:value, &Map.get(&1, :amount, 0))
    |> Map.update!(:paid_value, &Map.get(&1, :amount))
  end
end
