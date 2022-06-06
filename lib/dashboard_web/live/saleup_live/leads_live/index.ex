defmodule DashboardWeb.SaleupLive.LeadsLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}
  alias Dashboard.Entities.{Lead, Rebel}

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)


    socket = socket
             |> assign(current_user: current_user)
             |> fetch_leads

    {:ok, socket}
  end

  defp fetch_leads(socket) do
    leads = Entities.list_leads
            |> Repo.preload([:rebel, :calls, project: [:partner]])

    assign(socket, leads: leads)
  end

  @impl true
  def handle_event("delete_lead", %{"id" => lead_id}, socket) do
    lead = Entities.get_lead!(lead_id)

    socket = case Entities.delete_lead(lead) do
      {:ok, _lead} ->
        socket
        |> clear_flash
        |> put_flash(:success, "Lead wurde entfernt")
        |> fetch_leads
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> clear_flash
        |> put_flash(:error, "Lead konnte nicht enternt werden")
    end

    {:noreply, socket}
  end
end
