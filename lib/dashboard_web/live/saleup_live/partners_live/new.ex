defmodule DashboardWeb.SaleupLive.PartnersLive.New do
  use DashboardWeb, :live_view

  alias Dashboard.Accounts
  alias Dashboard.Entities.Partner

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    socket = socket
             |> assign(current_user: current_user)

    {:ok, socket}
  end
end
