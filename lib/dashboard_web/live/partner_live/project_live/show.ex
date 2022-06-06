defmodule DashboardWeb.PartnerLive.ProjectLive.Show do
  use DashboardWeb, :live_view
  import Ecto.Query

  alias Dashboard.{Repo, Accounts, Entities}
  alias Dashboard.Entities.{Rebel, Lead}
  alias Dashboard.Sales.Call
  alias Dashboard.Finance.Packet

  @impl true
  def mount(%{"id" => project_id}, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(:partner)

    project = Entities.get_project!(project_id)
              |> Repo.preload([:packets, :rebels, leads: [:calls]])

    socket = socket
             |> assign(current_user: current_user)
             |> assign(project: project)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, _params) do
    socket
  end

  defp commission_value(%Packet{} = packet) do
    unit = if packet.commission.percentage do
      "%"
    else
      "€"
    end

    "#{packet.commission.value}#{unit}"
  end

  defp closed_calls(project, rebel) do
    query =
      from c in Call,
      join: l in Lead,
      on: c.lead_id == l.id,
      join: r in Rebel,
      on: l.rebel_id == r.id,
      where: l.project_id == ^project.id,
      where: r.id == ^rebel.id,
      where: c.outcome == ^"Closing Call"

    Repo.all(query)
    |> Enum.count
  end
end
