defmodule BilletManager.InstallmentsBasis.Services.GetCustomers do
  @moduledoc """
  Responsible for get users from database
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @type customer :: Customer.t()
  @type changeset :: Ecto.Changeset.t()

  @doc """
  Returns a list of customers
  """
  @spec process :: {:ok, customer} | {:error, changeset}
  def process do
    {:ok, CustomerRepo.all()}
  end
end
