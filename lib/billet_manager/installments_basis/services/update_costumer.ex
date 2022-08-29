defmodule BilletManager.InstallmentsBasis.Services.UpdateCustomer do
  @moduledoc """
  Service that update customers
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @type customer :: Customer.t()
  @type changeset :: Ecto.Changeset.t()

  @doc """
  Update a customer. If the customer doesn't 
  exists, return an error.
  """
  @spec process(map) :: {:ok, customer} | {:error, :not_found | changeset}
  def process(%{cpf: cpf} = params) do
    with {:ok, customer} <- CustomerRepo.fetch_by(cpf: cpf) do
      params
      |> Map.delete(:cpf)
      |> CustomerRepo.update(customer)
    end
  end
end
