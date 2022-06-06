defmodule DashboardWeb.SaleupLive.PartnersLive.Show do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}

  @impl true
  def mount(%{"id" => partner_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    partner = Entities.get_partner!(partner_id)
              |> Repo.preload(:projects)

    changeset = Entities.change_partner(partner)

    socket = socket
             |> assign(current_user: current_user)
             |> assign(partner: partner)
             |> assign(changeset: changeset)

    {:ok, socket}
  end
end
