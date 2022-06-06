defmodule DashboardWeb.ModalComponent do
  use DashboardWeb, :live_component

  @impl true
  def update(assigns, socket) do
    title = Keyword.get(assigns.opts, :title, "")

    socket = socket
             |> assign(assigns)
             |> assign(title: title)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="phx-modal"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @id %>"
      phx-page-loading>

      <div class="phx-modal-content overflow-auto">
        <div class="flex justify-between w-full">
          <h1 class="text-2xl mb-4">
            <%= @title %>
          </h1>
          <div>
            <%= live_patch raw("&times;"), to: @return_to, class: "phx-modal-close" %>
          </div>
        </div>
        <%= live_component @socket, @component, @opts %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  def render_copy(assigns) do
    ~L"""
    <div class="fixed inset-0 w-full h-screen flex items-center justify-center bg-black bg-opacity-75">
      <div class="w-full max-w-2xl bg-white shadow-lg rounded-lg p-8">
        <h1 class="text-2xl">
          <%= @title %>
        </h1>
        <div class="my-4 max-h-3/4v overflow-y-auto">
          <%= @inner_content.([]) %>
        </div>
        <div class="flex justify-end">
          <button phx-click="<%= @callback %>">OK</button>
        </div>
      </div>
    </div>
    """
  end
end
