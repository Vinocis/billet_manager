defmodule BilletManagerWeb.Schemas.Billet.Type do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Possible bank billet statuses"
  enum :statuses do
    value(:opened)
    value(:paid)
    value(:expired)
  end

  @desc "Billet"
  object :billet do
    @desc "Unique code"
    field :code, :string

    @desc "Expiration time"
    field :expire_on, :date

    @desc "Status"
    field :status, :statuses

    @desc "Value in cents"
    field :value, :integer
  end
end
