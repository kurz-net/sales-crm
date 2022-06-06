defmodule DashboardWeb.CallItemComponent do
  use DashboardWeb, :live_component

  alias Dashboard.{Repo, Sales}

  def update(assigns, socket) do
    call = Sales.get_call!(assigns.call_id)
           |> Repo.preload(lead: [project: [:partner]])

    socket = socket
             |> assign(call: call)

    {:ok, socket}
  end
end
