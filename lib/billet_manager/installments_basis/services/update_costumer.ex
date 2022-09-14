defmodule BilletManager.InstallmentsBasis.Services.UpdateCustomer do
  @moduledoc """
  Service that update customers
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo

  @doc """
  Update a customer. If the customer doesn't 
  exists, return an error.
  """
  @impl true
  def process(%{cpf: cpf, input: attrs}) do
    with {:ok, customer} <- CustomerRepo.fetch_by(cpf: cpf) do
      CustomerRepo.update(customer, attrs)
    end
  end
end
