defmodule DashboardWeb.SaleupLive.ProjectsLive.New do
  use DashboardWeb, :live_view

  alias Dashboard.{Accounts, Entities}
  alias Dashboard.Entities.Project

  @impl true
  def mount(%{"id" => partner_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    partner = Entities.get_partner!(partner_id)

    changeset = %Project{}
                |> Entities.change_project

    socket = socket
             |> assign(current_user: current_user)
             |> assign(partner: partner)
             |> assign(changeset: changeset)

    {:ok, socket}
  end

  @impl true
  def handle_event("submit_project", %{"project" => project_params}, socket) do
    project_params = project_params
           |> Map.put("partner_id", socket.assigns.partner.id)

    socket = case Entities.create_project(project_params) do
      {:ok, project} ->
        IO.inspect project
        socket
        |> put_flash(:success, "Projekt wurde erstellt")
        |> assign(running_call: false)

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end
end
