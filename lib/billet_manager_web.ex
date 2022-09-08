defmodule BilletManagerWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use BilletManagerWeb, :controller
      use BilletManagerWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  alias BilletManagerWeb.BaseView

  import Phoenix.Controller, only: [put_view: 2, render: 3]
  import Plug.Conn, only: [put_status: 2]

  def controller do
    quote do
      use Phoenix.Controller, namespace: BilletManagerWeb

      import Plug.Conn
      import BilletManagerWeb.Gettext
      import BilletManagerWeb, only: [render_response: 2]

      alias BilletManagerWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/billet_manager_web/templates",
        namespace: BilletManagerWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import BilletManagerWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import BilletManagerWeb.ErrorHelpers
      import BilletManagerWeb.Gettext
      alias BilletManagerWeb.Router.Helpers, as: Routes
    end
  end

  def render_response(nil, _conn), do: nil

  @spec render_response(map | list, Plug.Conn.t()) :: Plug.Conn.t()
  def render_response(data, conn) do
    conn
    |> put_status(:ok)
    |> put_view(BaseView)
    |> render("response.json", data: data)
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
