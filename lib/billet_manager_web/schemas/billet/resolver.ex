defmodule BilletManagerWeb.Schemas.Billet.Resolver do
  @moduledoc false

  alias BilletManager.InstallmentsBasis.Models.Billet
  alias BilletManager.InstallmentsBasis.Services.CreateBillet

  @type changeset :: Ecto.Changeset.t()
  @type billet :: Billet.t()

  def create_billet(_parent, %{cpf: cpf, input: input}, _context) do
    with params <- Map.put(input, :cpf, cpf),
         {:ok, billet} <- CreateBillet.process(params) do
      {:ok, transform(billet)}
    end
  end

  defp transform(billet) do
    Map.update!(billet, :value, &Map.get(&1, :amount))
  end
end
