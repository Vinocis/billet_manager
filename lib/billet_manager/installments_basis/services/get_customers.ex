defmodule BilletManager.InstallmentsBasis.Services.GetCustomers do
  @moduledoc """
  Service that list customers
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @type customer :: Customer.t()
  @type changeset :: Ecto.Changeset.t()

  @doc """
  List customers
  """
  @spec process() :: {:ok, customer} | {:error, changeset}
  def process() do
    {:ok, CustomerRepo.all()}
  end
end
