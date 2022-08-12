defmodule BilletManagerWeb.BaseView do
  use BilletManagerWeb, :view

  def render("response.json", %{data: :empty}), do: %{}
  def render("response.json", %{data: data}), do: %{data: data}
end
