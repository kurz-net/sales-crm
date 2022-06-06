defmodule DashboardWeb.RebelLive.LeadsLive.Show do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}

  @impl true
  def mount(%{"id" => lead_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [:projects])

    lead = Entities.get_lead!(lead_id)
           |> Repo.preload([:calls, project: [:partner]])

    socket = socket
             |> assign(current_user: current_user)
             |> assign(lead: lead)

    {:ok, socket}
  end
end
