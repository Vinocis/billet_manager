defmodule BilletManager.InstallmentsBasis.Services.CreateBillet do
  @moduledoc """
  Service that creates bank billets
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Billet, as: BilletRepo
  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Billet

  @type billet :: Billet.t()
  @type changeset :: Ecto.Changeset.t()

  @doc """
  Fetches a customer and create a bank billet. If the customer
  doesn't exists, return an error.
  """
  @spec process(map) :: {:ok, billet} | {:error, :not_found | changeset}
  def process(%{cpf: cpf} = params) do
    with {:ok, customer} <- CustomerRepo.fetch_by(cpf: cpf) do
      params
      |> Map.delete(:cpf)
      |> Map.put(:customer_id, customer.id)
      |> BilletRepo.insert()
    end
  end
end
