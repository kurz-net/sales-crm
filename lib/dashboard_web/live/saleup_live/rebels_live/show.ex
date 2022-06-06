defmodule DashboardWeb.SaleupLive.RebelsLive.Show do
  use DashboardWeb, :live_view
  import Ecto.Query

  alias Dashboard.{Repo, Accounts, Entities, Sales}
  alias Dashboard.Sales.ProjectRebel

  def mount(%{"id" => rebel_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    socket = socket
             |> assign(current_user: current_user)
             |> fetch_rebel(rebel_id)

    {:ok, socket}
  end

  defp fetch_rebel(socket, rebel_id) do
    rebel = Entities.get_rebel!(rebel_id)
            |> Repo.preload(:projects)

    add_project_changeset =
      %ProjectRebel{}
      |> Sales.change_project_rebel

    project_ids = rebel.projects
                  |> Enum.map(&(&1.id))
    joinable_projects =
      Entities.list_projects
      |> Enum.filter(fn project ->
        project.id not in project_ids
      end)
      |> Repo.preload(:partner)

    socket
    |> assign(rebel: rebel)
    |> assign(add_project_changeset: add_project_changeset)
    |> assign(joinable_projects: joinable_projects)
  end

  def handle_event("remove_from_project", %{"project_id" => project_id}, socket) do
    project = Entities.get_project!(project_id)

    project_rebel =
      ProjectRebel
      |> where([pr], pr.project_id == ^project.id)
      |> where([pr], pr.rebel_id == ^socket.assigns.rebel.id)
      |> Repo.one()

    socket = case Sales.delete_project_rebel(project_rebel) do
      {:ok, _} ->
        socket
        |> fetch_rebel(socket.assigns.rebel.id)
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
    end

    {:noreply, socket}
  end

  def handle_event("submit_add_project", %{"project_rebel" => %{"project_id" => ""}}, socket) do
    socket =
      socket
      |> clear_flash
      |> put_flash(:error, "Projekt darf nicht leer sein")

    {:noreply, socket}
  end

  def handle_event("submit_add_project", %{"project_rebel" => %{"project_id" => project_id}}, %{assigns: %{rebel: rebel}} = socket) do
    project = Entities.get_project!(project_id)

    socket = case Sales.add_rebel_to_project(rebel, project) do
      {:ok, _} ->
        socket
        |> clear_flash
        |> put_flash(:success, "Rebel wurde zum Projekt hinzugefügt")
        |> fetch_rebel(rebel.id)
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(add_project_changeset: changeset)
    end

    {:noreply, socket}
  end
end
