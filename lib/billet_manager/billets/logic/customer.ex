defmodule BilletManager.Billets.Logic.Customer do
  def attrs_for_create(attrs) do
    %{
      name: attrs["customer_name"],
      cpf: attrs["customer_cpf"]
    }
  end
end
