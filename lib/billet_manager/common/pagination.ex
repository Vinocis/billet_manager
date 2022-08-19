defmodule BilletManager.Common.Pagination do
  @moduledoc """
  Modulo para paginação de resultados.
  """
  alias BilletManager.Repo

  import Ecto.Query

  @default_page 1
  @default_page_size 15

  @type query :: Ecto.Query.t()

  @doc """
  Função para paginação de resultados. A paginação começa da página 1.

  ## Exemplo

      iex> Common.Pagination.paginate(query, page: 1, page_size: 10)

  """
  @spec paginate(query, keyword) :: map
  def paginate(query, opts \\ []) do
    page = Keyword.get(opts, :page, @default_page)
    page_size = Keyword.get(opts, :page_size, @default_page_size)

    internal_page = page - 1

    result =
      query
      |> limit(^page_size)
      |> offset(^(internal_page * page_size))
      |> Repo.all()

    entries = Enum.slice(result, 0, page_size)
    total_entries = Repo.one(from(t in subquery(query), select: count("*")))

    %{
      total_entries: total_entries,
      total_pages: ceil(total_entries / page_size),
      page_number: page,
      page_size: length(entries),
      entries: entries
    }
  end
end
