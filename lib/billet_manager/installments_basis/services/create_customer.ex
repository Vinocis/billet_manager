defmodule BilletManager.InstallmentsBasis.Services.CreateCustomer do
  @moduledoc """
  Service that create customers
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @type customer :: Customer.t()
  @type changeset :: Ecto.Changeset.t()

  @doc """
  Create a customer. If the customer doesn't 
  exists, return an error.
  """
  @spec process(map) :: {:ok, customer} | {:error, changeset}
  def process(params) do
    CustomerRepo.insert(params)
  end
end
