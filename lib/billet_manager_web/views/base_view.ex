defmodule BilletManagerWeb.BaseView do
  use BilletManagerWeb, :view

  @spec render(binary, map) :: map
  def render("response.json", %{data: :empty}), do: %{}
  def render("response.json", %{data: data}), do: %{data: data}
end
