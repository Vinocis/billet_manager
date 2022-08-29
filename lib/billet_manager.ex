defmodule BilletManager do
  @moduledoc """
  BilletManager keeps the contexts that define your domain
  and business logic.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @self __MODULE__
    end
  end

  def repo do
    quote do
      @behaviour BilletManager.Repo

      @type changeset :: Ecto.Changeset.t()
      @type query :: Ecto.Query.t()

      import BilletManager.Repo, only: [fetch: 2, fetch_by: 2]
      alias BilletManager.Repo
    end
  end

  def application_service do
    quote do
      @behaviour BilletManager.ApplicationService
    end
  end

  def domain_service do
    quote do
      import Ecto.Changeset
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
