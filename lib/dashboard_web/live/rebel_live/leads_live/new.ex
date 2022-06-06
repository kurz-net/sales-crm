defmodule DashboardWeb.RebelLive.LeadsLive.New do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts}

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [projects: [:partner]])

    socket = socket
             |> assign(current_user: current_user)

    {:ok, socket}
  end
end
