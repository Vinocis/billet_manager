defmodule BilletManagerWeb.Schemas.Billet.Resolver do
  @moduledoc false

  alias BilletManager.InstallmentsBasis.Models.Billet
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

  defp transform([]), do: []

  defp transform([%{} | _rest] = billets) do
    Enum.map(billets, &%{&1 | value: &1.value.amount})
  end

  defp transform(%Billet{} = billet) do
    Map.update!(billet, :value, &Map.get(&1, :amount))
  end
end
