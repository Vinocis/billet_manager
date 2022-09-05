defmodule BilletManager.InstallmentsBasis.IO.Repo.Billet do
  @moduledoc """
  Module that interacts with the billets table
  """

  use BilletManager, :repo

  alias BilletManager.InstallmentsBasis.Models.Billet

  @doc """
  Create a new bank billet
  """
  @impl true
  def insert(attrs) do
    %Billet{}
    |> Billet.changeset(attrs)
    |> Repo.insert()
  end
end
