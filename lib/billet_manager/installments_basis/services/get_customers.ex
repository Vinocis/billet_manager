defmodule BilletManager.InstallmentsBasis.Services.GetCustomers do
  @moduledoc """
  Responsible for get users from database
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @doc """
  Returns a list of customers
  """
  @impl true
  def process do
    {:ok, CustomerRepo.all()}
  end
end
