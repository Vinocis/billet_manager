defmodule BilletManager.InstallmentsBasis.Services.CreateCustomer do
  @moduledoc """
  Service that create customers
  """
  use BilletManager, :application_service

  alias BilletManager.InstallmentsBasis.IO.Repo.Customer, as: CustomerRepo
  alias BilletManager.InstallmentsBasis.Models.Customer

  @doc """
  Create a customer. If the customer wasn't
  created returns an error.
  """
  @impl true
  def process(params) do
    CustomerRepo.insert(params)
  end
end
