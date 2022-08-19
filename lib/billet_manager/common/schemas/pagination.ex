defmodule BilletManager.Common.Schemas.Pagination do
  use Ecto.Schema

  import Ecto.Changeset

  @default_page 1
  @default_page_size 50

  @fields ~w(page page_size)a

  embedded_schema do
    field :page, :integer, default: @default_page
    field :page_size, :integer, default: @default_page_size
  end

  @spec changeset(map) :: {:ok, %__MODULE__{}} | {:error, Ecto.Changeset.t()}
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> maybe_normalize_page_size()
    |> maybe_apply_changes()
  end

  defp maybe_normalize_page_size(%Ecto.Changeset{valid?: true} = changeset) do
    page_size = get_change(changeset, :page_size)

    cond do
      is_nil(page_size) ->
        changeset

      page_size <= @default_page_size ->
        changeset

      true ->
        put_change(changeset, :page_size, @default_page_size)
    end
  end

  defp maybe_normalize_page_size(changeset), do: changeset

  def maybe_apply_changes(%Ecto.Changeset{} = changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} = changeset -> {:ok, apply_changes(changeset)}
      changeset -> {:error, changeset}
    end
  end
end
