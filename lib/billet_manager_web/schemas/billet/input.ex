defmodule BilletManagerWeb.Schemas.Billet.Input do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :billet_input do
    description("Fields to create a billet")

    @desc "Unique code"
    field :code, non_null(:string)

    @desc "Expiration time"
    field :expire_on, non_null(:date)

    @desc "Status"
    field :status, non_null(:statuses)

    @desc "Value in cents"
    field :value, non_null(:integer)
  end
end
