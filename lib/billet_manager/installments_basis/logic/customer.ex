defmodule BilletManager.InstallmentsBasis.Logic.Customer do
  def attrs_for_create(attrs) do
    %{
      name: attrs["customer_name"],
      cpf: attrs["customer_cpf"]
    }
  end

  def attrs_for_update(attrs) do
    %{name: attrs["customer_name"]}
  end
end
