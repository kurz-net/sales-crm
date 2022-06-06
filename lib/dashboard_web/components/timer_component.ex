defmodule DashboardWeb.TimerComponent do
  use DashboardWeb, :live_component

  def mount(socket) do
    socket = socket
             |> assign(timer: 0)
             |> assign(hours: 0, minutes: 0, seconds: 0)
             |> assign(running: false)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="<%= @id %>">
      <%= if @hours < 10, do: "0" %><%= @hours %>:<%= if @minutes < 10, do: "0" %><%= @minutes %>:<%= if @seconds < 10, do: "0" %><%= @seconds %>
    </div>
    """
  end

  def handle_info(:tick, %{assigns: %{running_session: running_session, timer: timer}} = socket) do
    socket = cond do
      running_session ->
        :timer.send_after(1000, self(), :tick)

        timer = timer + 1
        seconds = timer
        minutes = seconds / 60
        hours = minutes / 60

        seconds = trunc(seconds)
        minutes = trunc(minutes)
        hours = trunc(hours)

        seconds = rem(seconds, 60)
        minutes = rem(minutes, 60)

        socket
        |> assign(timer: timer)
        |> assign(seconds: seconds)
        |> assign(minutes: minutes)
        |> assign(hours: hours)
      true -> socket
    end

    {:noreply, socket}
  end

  def handle_event("start_timer", _, socket) do
    IO.inspect "HEY THERE"

    :timer.send_after(1000, self(), :tick)

    socket = socket
             |> assign(:running, true)

    {:noreply, socket}
  end

  def handle_event("stop_timer", _, socket) do
    socket = socket
             |> assign(:running, false)

    {:noreply, socket}
  end
end
