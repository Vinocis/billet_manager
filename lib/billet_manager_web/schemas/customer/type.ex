defmodule BilletManagerWeb.Schemas.Customer.Type do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Customer"
  object :customer do
    @desc "Name"
    field :name, :string

    @desc "CPF"
    field :cpf, :string
  end
end
