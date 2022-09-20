defmodule BilletManager.Common do
  @moduledoc """
  Module with helper functions to be used in other 
  contexts
  """

  @doc """
  Converts the Ecto.Changeset errors to an more legible map
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

  @doc """
  Parse a value to a Money struct (in cents)

  ##Example
    iex> BilletManager.Common.parse_to_money!(100)
    %Money{amount: 100, currency: :BRL}

    iex> BilletManager.Common.parse_to_money!("1.234,56")
    %Money{amount: 123456, currency: :BRL}
  """
  @spec parse_to_money!(integer, keyword) :: Money.t()
  def parse_to_money!(amount, opts \\ [separator: ".", delimiter: ","])
  def parse_to_money!(nil, _opts), do: nil
  def parse_to_money!(amount, _opts) when is_integer(amount), do: Money.new(amount, :BRL)
  def parse_to_money!(amount, opts), do: Money.parse!(amount, :BRL, opts)
end
