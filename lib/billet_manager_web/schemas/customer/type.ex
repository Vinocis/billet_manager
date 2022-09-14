defmodule BilletManagerWeb.Schemas.Customer.Type do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias BilletManagerWeb.Schemas.Billet.Resolver

  @desc "Customer"
  object :customer do
    @desc "Name"
    field :name, :string

    @desc "CPF"
    field :cpf, :string

    @desc "Bank billets"
    field :billets, list_of(:billet) do
      resolve(&Resolver.get_billets/3)
    end
  end
end
