defmodule BilletManager.Billets.Models.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias BilletManager.Billets.Models.Billet

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

  defp validate_cpf(changeset) do
    cpf = get_change(changeset, :cpf)

    if Brcpfcnpj.cpf_valid?(cpf) do
      changeset
    else
      add_error(changeset, :cpf, "invalid cpf")
    end
  end
end
