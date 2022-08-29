defmodule BilletManagerWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @doc """
  Translates an error message using gettext.
  """
  @spec translate_error({binary, keyword | map}) :: binary
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(BilletManagerWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(BilletManagerWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Format GraphQL API errors
  """
  @spec handle(Ecto.Changeset.t() | keyword | any) :: [map]
  def handle(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&translate_error/1)
    |> Enum.map(fn {k, v} ->
      %{field: k, message: List.first(v)}
    end)
  end

  def handle({field, message}) do
    [%{field: field, message: message}]
  end

  def handle(error) do
    [%{message: error}]
  end
end
