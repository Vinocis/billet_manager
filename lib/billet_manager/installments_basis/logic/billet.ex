defmodule BilletManager.InstallmentsBasis.Logic.Billet do
  @moduledoc """
  Logic module for Billet operations
  """

  @doc """
  Create the necessary attributes for create a customer

  ## Example
    
      iex> attrs = %{
              "billet_code" => "cod14135",
              "billet_expire_on" => "2022-10-03T14:08:48-03:00",
              "billet_source" => "paid"
              "billet_value" => 111,
           }
      iex> attrs_for_create(attrs)
      %{
        code: "11111.11111 11111.11111",
        expire_on: ~N[2022-10-03 14:08:48]
        source: :paid
        value: 250,
      }
  """
  @spec attrs_for_create(map) :: map
  def attrs_for_create(attrs) do
    %{
      customer_id: attrs["customer_id"] || nil,
      code: attrs["billet_code"],
      value: attrs["billet_value"],
      status: attrs["billet_status"] || :opened,
      expire_on: attrs["billet_expire_on"]
    }
  end
end
