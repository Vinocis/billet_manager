defmodule BilletManagerWeb.ErrorView do
  use BilletManagerWeb, :view

  alias BilletManager.Common

  @spec render(binary, map) :: map
  def render("error.json", %{reason: reason}) do
    %{errors: %{detail: reason}}
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: %{detail: Common.traverse_changeset_errors(changeset)}}
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
