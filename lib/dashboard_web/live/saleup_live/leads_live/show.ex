defmodule DashboardWeb.SaleupLive.LeadsLive.Show do
  use DashboardWeb, :live_view

  alias Dashboard.{Accounts, Entities}

  @impl true
  def mount(%{"id" => lead_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    lead = Entities.get_lead!(lead_id)

    socket = socket
             |> assign(current_user: current_user)
             |> assign(lead: lead)

    {:ok, socket}
  end
end
