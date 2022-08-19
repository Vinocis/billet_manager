defmodule BilletManager.InstallmentsBasis.Logic.Customer do
  @moduledoc """
  Logic module for Customer operations
  """

  @doc """
  Create the necessary attributes for create a customer

  ## Example
    
      iex> attrs = %{
              "customer_name" => "Jhon Doe",
              "customer_cpf" => "111.444.777-45"
           }
      iex> attrs_for_create(attrs)
      %{
        cpf: "111.444.777-45",
        name: "Jhon Doe"
      }
  """
  @spec attrs_for_create(map) :: map
  def attrs_for_create(attrs) do
    %{
      name: attrs["customer_name"],
      cpf: attrs["customer_cpf"]
    }
  end

  @doc """
  Create the necessary attributes for update a customer
  """
  @spec attrs_for_update(map) :: map
  def attrs_for_update(attrs) do
    %{name: attrs["customer_name"]}
  end
end
