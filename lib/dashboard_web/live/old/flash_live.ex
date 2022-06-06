defmodule DashboardWeb.FlashLive do
  use DashboardWeb, :live_view

  def mount(_params, _session, socket) do
    socket = socket
             |> clear_flash
             |> put_flash(:info, "mounted!")
             #|> put_flash(:info, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    {:ok, socket}
  end

  def handle_event("error", _session, socket) do
    socket = socket
             |> clear_flash
             |> put_flash(:error, "This is an alert!")
    {:noreply, socket}
  end
  def handle_event("info", _session, socket) do
    socket = socket
             |> clear_flash()
             |> put_flash(:info, "This is an alert!")
    {:noreply, socket}
  end
  def handle_event("success", _session, socket) do
    socket = socket
             |> clear_flash()
             |> put_flash(:success, "This is an alert!")
    {:noreply, socket}
  end
end
