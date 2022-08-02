defmodule BilletManager.Billets.Models.Billet do
  use Ecto.Schema
  import Ecto.Changeset

  alias BilletManager.Billets.Models.Customer

  @statuses ~w(
    opened
  )a

  @required_fields ~w(
    code
    value
    status
    expire_on
  )a

  schema "billets" do
    field :code, :string
    field :value, :integer
    field :status, Ecto.Enum, values: @statuses, default: :opened
    field :expire_on, :date

    belongs_to :customer, Customer, foreign_key: :customer_id

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

  defp validate_billet_value(changeset) do
    billet_value = get_change(changeset, :created_at)

    if billet_value > 0 do
      changeset
    else
      add_error(changeset, :value, "billet value must be greater than zero")
    end
  end

  defp validate_expire_time(changeset) do
    created_at = get_change(changeset, :created_at)
    expire_on = get_change(changeset, :expire_on)

    if is_expire_time_valid?(created_at, expire_on) do
      changeset
    else
      add_error(changeset, :expire_on, "expiration time must be greater than :created_at")
    end
  end

  defp is_expire_time_valid?(creation_time, expire_time) do
    case {creation_time, expire_time} do
      {nil, _} ->
        false

      {_, nil} ->
        false

      {creation_time, expire_time} ->
        valid = NaiveDateTime.diff(expire_time, creation_time) > 0

        if valid, do: true, else: false
    end
  end
end
