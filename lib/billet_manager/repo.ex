defmodule BilletManager.Repo do
  @moduledoc """
  Repo behaviour

  Implements a defalt behaviour to be followed in the
  repo contexts
  """

  use Ecto.Repo,
    otp_app: :billet_manager,
    adapter: Ecto.Adapters.Postgres

  alias BilletManager.InstallmentsBasis.Models.Billet
  alias BilletManager.InstallmentsBasis.Models.Customer

  @type changeset :: Ecto.Changeset.t()
  @type query :: Ecto.Query.t()

  @callback all() :: list(struct)
  @callback delete(struct) :: {:ok, struct} | {:error, changeset}
  @callback fetch(integer) :: {:ok, struct} | {:error, changeset}
  @callback fetch_by(keyword) :: {:ok, struct} | {:error, changeset}
  @callback insert(map) :: {:ok, struct} | {:error, changeset}
  @callback insert_or_update(map) :: {:ok, struct} | {:error, changeset}
  @callback update(struct, map) :: {:ok, struct} | {:error, changeset}

  @optional_callbacks [
    all: 0,
    delete: 1,
    fetch: 1,
    fetch_by: 1,
    insert: 1,
    insert_or_update: 1,
    update: 2
  ]

  @spec fetch(module | query, integer) :: {:ok, struct} | {:error, :not_found}
  def fetch(source, id) do
    fetch_by(source, id: id)
  end

  @spec fetch_by(module | query, keyword) :: {:ok, struct} | {:error, :not_found}
  def fetch_by(source, params) do
    error = normalize_fetch_error(source)

    case BilletManager.Repo.get_by(source, params) do
      nil -> {:error, error}
      model -> {:ok, model}
    end
  end

  def normalize_fetch_error(Billet), do: "Billet not found"
  def normalize_fetch_error(Customer), do: "Customer not found"
  def normalize_fetch_error(_source), do: "Not found"
end
