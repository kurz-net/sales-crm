defmodule DashboardWeb.RebelLive.LeadsLive.FormComponent do
  use DashboardWeb, :live_component
  import Ecto.Query

  alias Dashboard.{Repo, Entities}
  alias Dashboard.Sales.ProjectRebel

  @impl true
  def update(%{lead: lead} = assigns, socket) do
    lead = lead
           |> Repo.preload([:rebel, project: [:rebels]])

    changeset = Entities.change_lead(lead)

    projects = Entities.list_projects
               |> Repo.preload(:partner)

    rebels = if is_nil(lead.project) do
      []
    else
      lead.project.rebels
    end

    socket = socket
             |> assign(assigns)
             |> assign(changeset: changeset)
             |> assign(projects: projects)
             |> assign(rebels: rebels)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"lead" => lead_params}, socket) do
    changeset =
      socket.assigns.lead
      |> Entities.change_lead(lead_params)
      |> Map.put(:action, :validate)

    socket = socket
             |> assign(changeset: changeset)

    {:noreply, socket}
  end

  def handle_event("save", %{"lead" => lead_params}, socket) do
    lead_params = Map.put(lead_params, "rebel_id", socket.assigns.rebel.id)

    save_user(socket, socket.assigns.action, lead_params)
  end

  defp save_user(socket, :edit, lead_params) do
    socket = case Entities.update_lead(socket.assigns.lead, lead_params) do
      {:ok, lead} ->
        IO.inspect lead
        socket
        |> clear_flash
        |> put_flash(:success, "Lead wurde aktualisiert")
        |> redirect(to: socket.assigns.redirect_to)

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        assign(socket, :changeset, changeset)
    end

    {:noreply, socket}
  end

  defp save_user(socket, :new, lead_params) do
    socket = case Entities.create_lead(lead_params) do
      {:ok, _lead} ->
        socket
        |> clear_flash
        |> put_flash(:success, "Lead wurde erstellt!")
        |> redirect(to: socket.assigns.redirect_to)

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end

    {:noreply, socket}
  end
end
