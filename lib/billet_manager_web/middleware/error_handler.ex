defmodule BilletManagerWeb.Middleware.ErrorHandler do
  @moduledoc """
  Faz o tratamento de erros para o retorno na api do graphql.
  """

  @behaviour Absinthe.Middleware

  alias BilletManagerWeb.ErrorHelpers

  @impl Absinthe.Middleware
  def call(resolution, _config) do
    if length(resolution.errors) > 0 do
      %{resolution | errors: Enum.flat_map(resolution.errors, &ErrorHelpers.handle/1)}
    else
      resolution
    end
  end
end
