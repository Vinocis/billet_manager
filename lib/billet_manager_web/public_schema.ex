defmodule BilletManagerWeb.PublicSchema do
  @moduledoc false

  use Absinthe.Schema

  alias BilletManagerWeb.Middleware.ErrorHandler

  # types
  import_types(Absinthe.Type.Custom)
  import_types(BilletManagerWeb.Schemas.Customer.Type)
  import_types(BilletManagerWeb.Schemas.Billet.Type)

  # queries
  import_types(BilletManagerWeb.Schemas.Customer.Query)

  # mutations
  import_types(BilletManagerWeb.Schemas.Customer.Mutation)
  import_types(BilletManagerWeb.Schemas.Billet.Mutation)

  query do
    import_fields(:customers_query)
  end

  mutation do
    import_fields(:create_billet_mutation)
    import_fields(:create_customer_mutation)
    import_fields(:update_customer_mutation)
    import_fields(:billet_payment_mutation)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation],
    do: Enum.reverse([ErrorHandler] ++ middleware)

  def middleware(middleware, _field, _object), do: middleware
end
