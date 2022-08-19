defmodule BilletManager.Common do
  @doc """
  Converte os erros de um `Ecto.Changeset` para um mapa mais reconhecível.
  """
  @spec traverse_changeset_errors(Ecto.Changeset.t()) :: map
  def traverse_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _matches, key ->
        opts
        |> Keyword.get(Elixir.String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end
end
