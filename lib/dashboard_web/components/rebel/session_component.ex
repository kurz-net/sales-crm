defmodule DashboardWeb.SessionComponent do
  use DashboardWeb, :live_component
  import Ecto.Query

  alias Dashboard.{Repo, Sales}
  alias Dashboard.Sales.Session

  def update(assigns, socket) do
    rebel = assigns.rebel

    socket = socket
             |> assign(rebel: rebel)
             |> fetch_session
             |> fetch_timer

    {:ok, socket}
  end

  defp fetch_session(socket) do
    rebel = socket.assigns[:rebel]

    session = Session
              |> where([s], s.rebel_id == ^rebel.id)
              |> where([s], is_nil(s.end))
              |> Repo.one

    assign(socket, session: session)
  end

  defp fetch_timer(socket) do
    case socket.assigns[:session] do
      nil ->
        reset_timer(socket)
      session ->
        :timer.send_after(1000, self(), :tick)

        timer = NaiveDateTime.diff(NaiveDateTime.utc_now, session.inserted_at)
        socket
        |> assign(timer: timer)
        |> units_from_timer
    end
  end

  defp reset_timer(socket) do
    socket
    |> assign(timer: 0)
    |> assign(hours: 0, minutes: 0, seconds: 0)
  end

  defp units_from_timer(socket) do
    seconds = socket.assigns[:timer]
    minutes = seconds / 60
    hours = minutes / 60

    seconds = trunc(seconds)
    minutes = trunc(minutes)
    hours = trunc(hours)

    seconds = rem(seconds, 60)
    minutes = rem(minutes, 60)

    socket
    |> assign(seconds: seconds)
    |> assign(minutes: minutes)
    |> assign(hours: hours)
  end

  def handle_event("start_session", _, %{assigns: %{rebel: rebel}}= socket) do
    session = %Session{ rebel: rebel }
              |> Repo.insert!

    :timer.send_after(1000, self(), :tick)

    socket = socket
             |> reset_timer
             |> assign(session: session)

    {:noreply, socket}
  end

  def handle_event("stop_session", _, %{assigns: %{session: session}}= socket) do
    session
    |> Sales.update_session(%{end: NaiveDateTime.utc_now})

    socket = socket
             |> assign(session: nil)

    {:noreply, socket}
  end
end
