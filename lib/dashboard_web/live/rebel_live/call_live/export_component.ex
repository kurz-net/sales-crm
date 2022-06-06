defmodule DashboardWeb.RebelLive.CallLive.ExportComponent do
  use DashboardWeb, :live_component

  alias Dashboard.{Sales, Repo}

  def update(%{call_id: call_id} = assigns, socket) do
    call = Sales.get_call!(call_id)
           |> Repo.preload([:documentation, lead: [:project]])

    {:ok,
     socket
     |> assign(assigns)
     |> assign(call: call)}
  end
end
