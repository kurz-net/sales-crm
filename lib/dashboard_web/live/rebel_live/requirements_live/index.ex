defmodule DashboardWeb.RebelLive.RequirementsLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}

  def mount(_params, session, socket) do
    socket = socket
             |> fetch_current_user(session)
             |> fetch_requirements

    {:ok, socket}
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
      |> Repo.preload(rebel: [:sessions, calls: [project: [:partner]]])

    assign(socket, current_user: current_user)
  end

  defp fetch_requirements(%{assigns: %{current_user: current_user}} = socket) do
    requirements = Entities.get_rebel_requirements(current_user.rebel)

    socket
    |> assign(requirements: requirements)
  end
end
