defmodule BilletManager.InstallmentsBasis.Adapters.Pagination do
  @moduledoc """
  Adapter responsável por converter campos usamos no módulo `Cobranca.Common.Schemas.Pagination`.
  """

  alias BilletManager.InstallmentsBasis.Schemas.Pagination, as: PaginationSchema

  @type changeset :: Ecto.Changeset.t()
  @type pagination_schema :: PaginationSchema.t()

  @doc """
  Converte parâmetros na struct de `Cobranca.Common.Schemas.Pagination`.

  `page_size` máximo é 50. Se informado um `page_size` maior, o schema ajusta para 50.
  Se nenhum page_size for informado, usamos 50 como padrão

  ### Exemplos

      iex> params_to_internal_pagination(%{"page" => 2, "page_size" => 30})
      {:ok, %Cobranca.Common.Schemas.Pagination{page: 2, page_size: 30}}

      iex> params_to_internal_pagination(%{"page" => 2, "page_size" => 60})
      {:ok, %Cobranca.Common.Schemas.Pagination{page: 2, page_size: 50}}

      iex> params_to_internal_pagination(%{})
      {:ok, %Cobranca.Common.Schemas.Pagination{page: 1, page_size: 50}}

  """
  @spec params_to_internal_pagination(map) :: {:ok, pagination_schema} | {:error, changeset}
  def params_to_internal_pagination(params) do
    PaginationSchema.changeset(params)
  end
end
