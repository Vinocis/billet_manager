defmodule BilletManager.Billets do
  alias BilletManager.Billets.Db
  alias BilletManager.Billets.Logic.Billet, as: BilletLogic
  alias BilletManager.Billets.Logic.Customer, as: CustomerLogic

  def create_customer_and_billet(attrs) do
    billet = BilletLogic.attrs_for_create(attrs)
    customer = CustomerLogic.attrs_for_create(attrs)

    customer_and_billet =
      Enum.reduce(customer, billet, fn {customer_key, customer_value}, billet ->
        Map.put(billet, customer_key, customer_value)
      end)

    Db.insert_customer_and_billet(customer_and_billet)
  end
end
