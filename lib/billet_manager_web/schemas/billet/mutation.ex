defmodule BilletManagerWeb.Schemas.Billet.Mutation do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias BilletManagerWeb.Schemas.Billet.Resolver

  import_types(BilletManagerWeb.Schemas.Billet.Input)

  object :create_billet_mutation do
    @desc "Create a new billet"
    field :create_billet, type: :billet do
      arg(:input, non_null(:billet_input))
      arg(:cpf, non_null(:string), description: "Customer CPF")
      resolve(&Resolver.create_billet/3)
    end
  end
end
