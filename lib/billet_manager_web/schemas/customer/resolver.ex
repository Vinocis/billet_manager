defmodule BilletManagerWeb.Schemas.Customer.Resolver do
  @moduledoc false

  alias BilletManager.InstallmentsBasis.Services.CreateCustomer
  alias BilletManager.InstallmentsBasis.Services.GetCustomers
  alias BilletManager.InstallmentsBasis.Services.UpdateCustomer

  def get_customers(_parent, _params, _context) do
    GetCustomers.process()
  end

  def create_customer(_parent, %{input: input}, _context) do
    CreateCustomer.process(input)
  end

  def update_customer(_parent, params, _context) do
    UpdateCustomer.process(params)
  end
end
