defmodule BilletManagerWeb.Schemas.Customer.Input do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :customer_input do
    description("Fields to create and update a customer")

    @desc "Customer name"
    field :name, non_null(:string)

    @desc "Customer CPF"
    field :cpf, non_null(:string)
  end
end
