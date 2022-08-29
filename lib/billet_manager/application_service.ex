defmodule BilletManager.ApplicationService do
  @moduledoc """
  Application services behaviour
  """

  @callback process(map) :: {:ok, term} | {:error, term}
  @callback process() :: {:ok, term} | {:error, term}

  @optional_callbacks process: 1, process: 0
end
