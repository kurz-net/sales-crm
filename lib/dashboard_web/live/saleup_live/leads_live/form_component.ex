defmodule DashboardWeb.SaleupLive.LeadsLive.FormComponent do
  use DashboardWeb, :live_component
  import Ecto.Query

  alias Dashboard.{Repo, Entities}
  alias Dashboard.Entities.Lead
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

    project_id = lead_params["project_id"]
    {rebels, changeset} = if project_id == "" do
      # No project was select, so also delete selected rebel
      {
        [],
        Ecto.Changeset.delete_change(changeset, :rebel_id)
      }
    else
      project_id = String.to_integer(project_id)

      query =
        from pr in ProjectRebel,
        preload: [:project, :rebel],
        where: pr.project_id == ^project_id

      rebels = query
               |> Repo.all
               |> Enum.map(&(&1.rebel))

      rebel_id = lead_params["rebel_id"]
      changeset = if rebel_id == "" do
        # Project was select, but rebel is still empty
        changeset
      else
        rebel_id = String.to_integer(rebel_id)
        rebel_ids = rebels |> Enum.map(&(&1.id))
        if rebel_id in rebel_ids do
          # Project was select, but selected rebel is part of it
          changeset
        else
          # Project was select, but selected rebel is NOT part of it
          Ecto.Changeset.delete_change(changeset, :rebel_id)
        end
      end

      {rebels, changeset}
    end

    socket = socket
             |> assign(changeset: changeset)
             |> assign(rebels: rebels)

    {:noreply, socket}
  end

  def handle_event("save", %{"lead" => lead_params}, socket) do
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
