defmodule DashboardWeb.RebelLive.CallLive.Show do
  use DashboardWeb, :live_view

  alias Dashboard.{Accounts, Repo}

  @impl true
  def mount(%{"id" => call_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(:rebel)

    socket = socket
             |> assign(current_user: current_user)
             |> assign(call_id: call_id)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, _params) do
    socket
  end

  defp apply_action(socket, :export, _params) do
    socket
  end
end
