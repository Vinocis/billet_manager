defmodule BilletManager.InstallmentsBasis.Models.Billet do
  use Ecto.Schema

  alias BilletManager.InstallmentsBasis.Models.Customer

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
  )a

  schema "billets" do
    field :code, :string
    field :value, Money.Ecto.Amount.Type
    field :status, Ecto.Enum, values: @statuses, default: :opened
    field :expire_on, :naive_datetime

    belongs_to :customer, Customer

    timestamps()
  end

  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_expire_time(model)
    |> validate_billet_value()
    |> unique_constraint(:code)
  end

  defp validate_billet_value(changeset) do
    case get_change(changeset, :value) do
      %Money{amount: amount} ->
        if amount > 0 do
          changeset
        else
          add_error(changeset, :value, "billet value must be greater than 0")
        end

      _ ->
        changeset
    end
  end

  defp validate_expire_time(changeset, model) do
    expire_changes = get_change(changeset, :expire_on)
    expire_model = model.expire_on

    cond do
      is_nil(expire_changes) && is_expire_time_valid?(expire_model) ->
        changeset

      not is_nil(expire_changes) && is_expire_time_valid?(expire_changes) ->
        changeset

      true ->
        add_error(changeset, :expire_on, "expiration time must be greater than :inserted_at")
    end
  end

  defp is_expire_time_valid?(expire_time) do
    NaiveDateTime.diff(expire_time, NaiveDateTime.utc_now()) > 0
  end
end
