defmodule DashboardWeb.CallComponent do
  use DashboardWeb, :live_component

  alias Dashboard.{Sales, Repo}

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{call_id: call_id}, socket) do
    call = Sales.get_call!(call_id)
           |> Repo.preload([:documentation, lead: [:project]])

    changeset = Sales.change_call(call)

    socket = socket
             |> assign(changeset: changeset)
             |> assign(call: call)

    {:ok, socket}
  end
end
