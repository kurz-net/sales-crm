defmodule DashboardWeb.RebelLive.LeadsLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts}
  alias Dashboard.Entities.Lead

  @impl true
  def mount(_params, session, socket) do
    socket = socket
             |> fetch_current_user(session)

    {:ok, socket}
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [leads: [:calls, project: [:partner]]])

    assign(socket, current_user: current_user)
  end
end
