defmodule BilletManagerWeb.Dto.V1.CustomerRequest do
  @moduledoc false

  use Ecto.Schema

  alias BilletManager.InstallmentsBasis.Logic.Customer, as: CustomerLogic

  import Ecto.Changeset

  @required_fields ~w(
    name
    cpf
  )a

  @primary_key false
  embedded_schema do
    field :name, :string
    field :cpf, :string
  end

  @spec create_changeset(map) :: {:ok, map} | {:error, Ecto.Changeset.t()}
  def create_changeset(attrs) do
    attrs = CustomerLogic.attrs_for_create(attrs)

    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> apply_action(:insert)
    |> maybe_return_attrs()
  end

  def update_changeset(attrs) do
    attrs = CustomerLogic.attrs_for_update(attrs)

    %__MODULE__{}
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> apply_action(:update)
    |> maybe_return_attrs()
  end

  defp maybe_return_attrs(result) do
    case result do
      {:ok, customer} ->
        attrs = Map.from_struct(customer)
        {:ok, attrs}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
