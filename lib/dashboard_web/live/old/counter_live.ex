defmodule DashboardWeb.CounterLive do
  use DashboardWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(
      socket,
      counter: 0
    )
    {:ok, socket}
  end

  def handle_event("increase", _session, socket) do
    socket = update(socket, :counter, &(&1 + 1))
    {:noreply, socket}
  end
  def handle_event("decrease", _session, socket) do
    socket = update(socket, :counter, &(&1 - 1))
    {:noreply, socket}
  end
  def handle_event("reset", _session, socket) do
    {:noreply, assign(socket, counter: 0)}
  end
end
