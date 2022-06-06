defmodule DashboardWeb.RebelLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}

  @impl true
  def mount(_params, session, socket) do
    socket = socket
             |> fetch_current_user(session)
             |> fetch_requirements
             |> assign(paginate: %{page: 1, per_page: 5})
             |> fetch_max_pages
             |> fetch_calls

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"page" => page, "per_page" => per_page}) do
    page = String.to_integer(page)
    per_page = String.to_integer(per_page)

    socket
    |> assign(export: nil)
    |> assign(paginate: %{page: page, per_page: per_page})
    |> fetch_calls
  end
  defp apply_action(socket, :index, _params) do
    socket
    |> assign(export: nil)
  end

  defp apply_action(socket, :export, %{"call_id" => call_id}) do
    socket
    |> assign(export: call_id)
  end

  defp fetch_max_pages(%{assigns: %{current_user: %{rebel: rebel}, paginate: %{per_page: per_page}}} = socket) do
    calls = Entities.get_rebel_calls(rebel)

    max_pages = ceil(length(calls) / per_page)
                |> max(1)

    assign(socket, max_pages: max_pages)
  end

  defp fetch_calls(%{assigns: %{current_user: %{rebel: rebel}, paginate: %{page: page, per_page: per_page}}} = socket) do
    calls = Entities.get_rebel_calls(rebel)
            |> Enum.sort(fn a, b ->
              :gt == NaiveDateTime.compare(a.inserted_at, b.inserted_at)
            end)
            |> Enum.drop((page - 1) * per_page)
            |> Enum.take(per_page)

    socket
    |> assign(calls: calls)
  end

  defp fetch_requirements(socket) do
    requirements = Entities.get_rebel_requirements(socket.assigns.current_user.rebel)

    socket
    |> assign(requirements: requirements)
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [projects: [:partner]])

    assign(socket, current_user: current_user)
  end

  @impl true
  def handle_info(:tick, %{assigns: %{current_user: current_user}} = socket) do
    send_update DashboardWeb.SessionComponent, [id: :session, rebel: current_user.rebel]
    {:noreply, socket}
  end
end
