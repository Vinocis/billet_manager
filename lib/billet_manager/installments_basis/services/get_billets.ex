defmodule BilletManager.InstallmentsBasis.Services.GetBillets do
  @moduledoc """
  Responsible for get billets from database
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Billet, as: BilletRepo
  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo

  @doc """
  Returns a list of billets
  """

  def process(%{cpf: cpf}) do
    with {:ok, customer} <- CustomerRepo.fetch_by(cpf: cpf),
         billets <- BilletRepo.get_billets_by_customer_id(customer.id) do
      {:ok, billets}
    end
  end
end
