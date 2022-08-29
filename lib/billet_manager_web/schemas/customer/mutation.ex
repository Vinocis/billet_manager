defmodule BilletManagerWeb.Schemas.Customer.Mutation do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias BilletManagerWeb.Schemas.Customer.Resolver

  import_types(BilletManagerWeb.Schemas.Customer.Input)

  object :create_customer_mutation do
    @desc "Create a new entry on customer"
    field :create_customer, type: :customer do
      arg(:input, non_null(:customer_input))
      resolve(&Resolver.create_customer/3)
    end
  end

  object :update_customer_mutation do
    @desc "Updates a customer"
    field :update_customer, type: :customer do
      arg(:input, non_null(:customer_input))
      resolve(&Resolver.update_customer/3)
    end
  end
end
