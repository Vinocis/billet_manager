defmodule BilletManager.Billets.Db do
  alias BilletManager.Billets.Models.Billet
  alias BilletManager.Billets.Models.Customer
  alias BilletManager.Billets.Queries.Customer, as: CustomerQueries
  alias BilletManager.Billets.Queries.Billet, as: BilletQueries
  alias BilletManager.Repo

  def maybe_insert_customer(attrs) do
    case get_customer_by_params(cpf: attrs.cpf) do
      [] ->
        %Customer{}
        |> Customer.changeset(attrs)
        |> Repo.insert()

      [customer] ->
        {:ok, customer}
    end
  end

  def insert_or_update_billet(attrs) do
    with [] <- get_billets_by_params(code: attrs.code),
         [customer] <- get_customer_by_params(cpf: attrs.cpf) do
      customer
      |> Ecto.build_assoc(:billets)
      |> Billet.changeset(attrs)
      |> Repo.insert()
    else
      [%Billet{} = billet] ->
        billet
        |> Billet.changeset(attrs)
        |> Repo.update()

      _other ->
        {:error, :customer_not_found}
    end
  end

  def insert_customer_and_billet(attrs) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:customer, fn _repo, _map ->
      maybe_insert_customer(attrs)
    end)
    |> Ecto.Multi.run(:billet, fn _repo, _customer ->
      insert_or_update_billet(attrs)
    end)
    |> Repo.transaction()
  end

  def get_customer_by_params(params) do
    params
    |> CustomerQueries.get_customers()
    |> Repo.all()
  end

  def get_billets_by_params(params) do
    params
    |> BilletQueries.get_billets()
    |> Repo.all()
  end

  def changeset_errors_to_string(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {message, _}} -> "#{field}: #{message}\n" end)
    |> List.to_string()
  end
end
