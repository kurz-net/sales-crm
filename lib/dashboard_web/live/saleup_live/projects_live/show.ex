defmodule DashboardWeb.SaleupLive.ProjectsLive.Show do
  use DashboardWeb, :live_view
  import Ecto.Query

  alias Dashboard.{Repo, Accounts, Entities, Sales}
  alias Dashboard.Sales.ProjectRebel

  @impl true
  def mount(%{"id" => project_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    socket = socket
             |> assign(current_user: current_user)
             |> fetch_project(project_id)

    {:ok, socket}
  end

  defp fetch_project(socket, project_id) do
    project = Entities.get_project!(project_id)
              |> Repo.preload([:partner, :rebels])

    add_rebel_changeset =
      %ProjectRebel{}
      |> Sales.change_project_rebel

    rebel_ids = project.rebels
                |> Enum.map(&(&1.id))
    available_rebels =
      Entities.list_rebels
      |> Enum.filter(fn rebel ->
        rebel.id not in rebel_ids
      end)

    socket
    |> assign(project: project)
    |> assign(add_rebel_changeset: add_rebel_changeset)
    |> assign(available_rebels: available_rebels)
  end

  @impl true
  def handle_event("remove_from_project", %{"rebel_id" => rebel_id}, socket) do
    rebel = Entities.get_rebel!(rebel_id)

    project_rebel =
      ProjectRebel
      |> where([pr], pr.rebel_id == ^rebel.id)
      |> where([pr], pr.project_id == ^socket.assigns.project.id)
      |> Repo.one()

    socket = case Sales.delete_project_rebel(project_rebel) do
      {:ok, _} ->
        socket
        |> fetch_project(socket.assigns.project.id)
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
    end

    {:noreply, socket}
  end

  @impl true
  def handle_event("submit_add_project", %{"project_rebel" => %{"rebel_id" => ""}}, socket) do
    socket =
      socket
      |> clear_flash
      |> put_flash(:error, "Rebel darf nicht leer sein")

    {:noreply, socket}
  end

  @impl true
  def handle_event("submit_add_project", %{"project_rebel" => %{"rebel_id" => rebel_id}}, %{assigns: %{project: project}} = socket) do
    rebel = Entities.get_rebel!(rebel_id)

    socket = case Sales.add_rebel_to_project(project, rebel) do
      {:ok, _} ->
        socket
        |> clear_flash
        |> put_flash(:success, "Rebel wurde zum Projekt hinzugefügt")
        |> fetch_project(project.id)
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(add_project_changeset: changeset)
    end

    {:noreply, socket}
  end
end
