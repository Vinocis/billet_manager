defmodule BilletManager.InstallmentsBasis.Models.Billet do
  @moduledoc false
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
    |> validate_expire_time()
    |> validate_billet_value()
    |> unique_constraint(:code)
  end

  defp validate_billet_value(%{changes: %{value: %Money{amount: amount}}} = changeset) do
    if amount > 0 do
      changeset
    else
      add_error(
        changeset,
        :value,
        "billet value must be greater than 0"
      )
    end
  end

  defp validate_billet_value(changeset), do: changeset

  defp validate_expire_time(%{changes: %{expire_on: expire_on}} = changeset) do
    if is_expire_time_valid?(expire_on) do
      changeset
    else
      add_error(
        changeset,
        :expire_on,
        "expiration time must be greater than :inserted_at"
      )
    end
  end

  defp validate_expire_time(changeset), do: changeset

  defp is_expire_time_valid?(expire_time) do
    expire_time
    |> NaiveDateTime.diff(NaiveDateTime.utc_now())
    |> Kernel.>(0)
  end
end
