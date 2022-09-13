defmodule BilletManager.InstallmentsBasis.Services.UpdateCustomer do
  @moduledoc """
  Service that update customers
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @doc """
  Update a customer. If the customer doesn't 
  exists, return an error.
  """
  @impl true
  def process(%{cpf: cpf} = params) do
    with {:ok, customer} <- CustomerRepo.fetch_by(cpf: cpf) do
      CustomerRepo.update(customer, params)
    end
  end
end
