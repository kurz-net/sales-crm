defmodule DashboardWeb.PartnerLive.Index do
  use DashboardWeb, :live_view
  import Ecto.Query

  alias Dashboard.{Accounts, Sales, Repo}
  alias Dashboard.Entities.{Project, Lead}
  alias Dashboard.Sales.Call

  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(partner: [:projects])

    # Query all Calls matching the current Partner
    calls = Repo.all from c in Call,
      join: l in Lead,
      on: c.lead_id == l.id,
      join: p in Project,
      on: l.project_id == p.id,
      where: p.partner_id == ^current_user.partner.id,
      where: c.outcome == "Closing Call"

    # Filter for calls that don't haven't been credited yet
    # Sort call date
    calls = calls
            |> Repo.preload([:rebel_credit, lead: [:project]])
            |> Enum.filter(&is_nil(&1.rebel_credit))
            |> Enum.sort(fn a, b ->
              case NaiveDateTime.compare(a.follow_up, b.follow_up) do
                :lt -> true
                _ -> false
              end
            end)

    # Put an overdue flag on every call, for color highlighting
    overdue_calls = Enum.filter(calls, &(NaiveDateTime.compare(&1.follow_up, NaiveDateTime.utc_now) != :gt))
    due_calls = Enum.filter(calls, &(NaiveDateTime.compare(&1.follow_up, NaiveDateTime.utc_now) == :gt))

    socket = socket
             |> assign(current_user: current_user)
             |> assign(due_calls: due_calls)
             |> assign(overdue_calls: overdue_calls)
             |> assign(credit: nil)

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(credit: nil)
  end

  defp apply_action(socket, :credit, %{"call_id" => call_id}) do
    call = Sales.get_call!(call_id)
           |> Repo.preload([:rebel, [project: [:packets]]])

    socket
    |> assign(credit: call)
  end
end
