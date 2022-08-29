defmodule BilletManagerWeb.Schemas.Customer.Type do
  use Absinthe.Schema.Notation

  @desc "Customer"
  object :customer do
    @desc "Customer name"
    field :name, :string

    @desc "Customer CPF"
    field :cpf, :string
  end
end
