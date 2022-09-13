defmodule BilletManager.InstallmentsBasis.Services.CreateBillet do
  @moduledoc """
  Service that creates bank billets
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Billet, as: BilletRepo
  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Billet

  @doc """
  Fetches a customer and create a bank billet. If the customer
  doesn't exists, return an error.
  """
  @impl true
  def process(%{cpf: cpf, input: attrs}) do
    with {:ok, customer} <- CustomerRepo.fetch_by(cpf: cpf) do
      attrs
      |> Map.put(:customer_id, customer.id)
      |> BilletRepo.insert()
    end
  end
end
