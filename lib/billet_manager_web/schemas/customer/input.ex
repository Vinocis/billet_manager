defmodule BilletManagerWeb.Schemas.Customer.Input do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :create_customer_input do
    description("Fields to create a customer")

    @desc "Name"
    field :name, non_null(:string)

    @desc "CPF"
    field :cpf, non_null(:string)
  end

  input_object :update_customer_input do
    description("Fields to update a customer")

    @desc "Name"
    field :name, non_null(:string)
  end
end
