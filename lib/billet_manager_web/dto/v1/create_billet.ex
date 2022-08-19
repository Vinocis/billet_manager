defmodule BilletManagerWeb.Dto.V1.CreateBillet do
  @moduledoc false

  use Ecto.Schema

  alias BilletManager.InstallmentsBasis.Logic.Billet, as: BilletLogic

  import Ecto.Changeset

  @statuses ~w(
    opened
    paid
    expired
  )a

  @required_fields ~w(
    code
    value
    status
    expire_on
    customer_id
  )a

  @primary_key false
  embedded_schema do
    field :code, :string
    field :value, Money.Ecto.Amount.Type
    field :status, Ecto.Enum, values: @statuses, default: :opened
    field :expire_on, :naive_datetime
    field :customer_id, :integer
  end

  @spec changeset(map) :: {:ok, map} | {:error, Ecto.Changeset.t()}
  def changeset(attrs) do
    attrs = BilletLogic.attrs_for_create(attrs)

    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> apply_action(:insert)
    |> maybe_return_attrs()
  end

  defp maybe_return_attrs(result) do
    case result do
      {:ok, billet} ->
        attrs = Map.from_struct(billet)
        {:ok, attrs}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
