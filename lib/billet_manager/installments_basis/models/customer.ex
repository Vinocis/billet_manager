defmodule BilletManager.InstallmentsBasis.Models.Customer do
  @moduledoc false

  use BilletManager, :model

  alias BilletManager.InstallmentsBasis.Models.Billet

  import Ecto.Changeset

  @required_fields ~w(
    name
    cpf
  )a

  schema "customers" do
    field :name, :string
    field :cpf, :string

    has_many :billets, Billet

    timestamps()
  end

  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_cpf()
    |> unique_constraint(:cpf)
  end

  defp validate_cpf(%{changes: %{cpf: cpf}} = changeset) do
    cond do
      Brcpfcnpj.cpf_valid?(cpf) ->
        changeset

      true ->
        add_error(changeset, :cpf, "invalid cpf")
    end
  end

  defp validate_cpf(changeset), do: changeset
end
