defmodule DashboardWeb.SaleupLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Finance}
  alias Dashboard.Sales.PerformanceRequirement
  import Ecto.Query

  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    credits = Finance.list_rebel_credits
              |> Repo.preload([:packet, call: [lead: [:rebel, :project]]])

    socket = socket
             |> assign(current_user: current_user)
             |> assign(credits: credits)
             |> fetch_requirements

    {:ok, socket}
  end

  defp fetch_requirements(socket) do
    requirements = PerformanceRequirement
                   |> where([pr], pr.from_date <= ^Date.utc_today)
                   |> where([pr], pr.to_date >= ^Date.utc_today)
                   |> preload([:rebel, :partner])
                   |> Repo.all

    socket
    |> assign(requirements: requirements)
  end
end
