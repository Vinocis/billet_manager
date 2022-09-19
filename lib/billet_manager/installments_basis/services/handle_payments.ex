defmodule BilletManager.InstallmentsBasis.Services.HandlePayments do
  @moduledoc """
  Responsible for update the billet `status` and `paid_value`
  fields depending on the paid amount
  """
  use BilletManager, :application_service

  alias BilletManager.Common
  alias BilletManager.InstallmentsBasis.IO.Repo.Billet, as: BilletRepo

  @can_receive_payments ~w(partially_paid opened)a

  @doc """
  Case the paid amount is lesser than the billet value, change the status to
  `partially_paid`, and if is greater than the billet value change the status 
  to `paid`. In any other case returns an error.
  """
  @impl true
  def process(%{code: code, input: attrs}) do
    with {:ok, billet} <- BilletRepo.fetch_by(code: code),
         {:ok, attrs} <- maybe_put_status_on_attrs(billet, attrs) do
      BilletRepo.update(billet, attrs)
    end
  end

  defp maybe_put_status_on_attrs(billet, attrs) when billet.status in @can_receive_payments do
    paid_value = Common.parse_integer_to_money!(attrs.payment_value)

    cond do
      Money.compare(billet.value, paid_value) > 0 ->
        attrs =
          attrs
          |> Map.delete(:payment_value)
          |> Map.put(:status, :partially_paid)
          |> Map.put(:paid_value, paid_value)

        {:ok, attrs}

      Money.compare(billet.value, paid_value) <= 0 ->
        attrs =
          attrs
          |> Map.delete(:payment_value)
          |> Map.put(:status, :paid)
          |> Map.put(:paid_value, paid_value)

        {:ok, attrs}
    end
  end

  defp maybe_put_status_on_attrs(_billet, _attrs) do
    {:error, "This billet can't receive more payments"}
  end
end
