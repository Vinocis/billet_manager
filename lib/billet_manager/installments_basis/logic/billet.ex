defmodule BilletManager.InstallmentsBasis.Logic.Billet do
  def attrs_for_create(attrs) do
    %{
      code: attrs["billet_code"],
      value: attrs["billet_value"],
      status: attrs["billet_status"] || :opened,
      expire_on: attrs["billet_expire_on"]
    }
  end
end
