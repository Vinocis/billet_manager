defmodule BilletManagerWeb.Schemas.Customer.Query do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias BilletManagerWeb.Schemas.Customer.Resolver

  object :customers_query do
    field :customers, list_of(:customer) do
      resolve(&Resolver.get_customers/3)
    end
  end
end
