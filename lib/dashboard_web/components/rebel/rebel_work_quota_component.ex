defmodule DashboardWeb.RebelWorkQuotaComponent do
  use DashboardWeb, :live_component

  alias Dashboard.{Repo, Metrics}

  def update(assigns, socket) do
    rebel = assigns.rebel
            |> Repo.preload([:work_quotas])

    work_quotas =
      rebel.work_quotas
      |> Enum.filter(fn wq ->
        Date.range(wq.from_date, wq.to_date)
        |> Enum.member?(Date.utc_today)
      end)
      |> Enum.take(1)

    work_quota = case work_quotas do
      [] -> nil
      [work_quota | _] -> work_quota
    end

    socket = socket
             |> assign(rebel: rebel)
             |> assign(work_quota: work_quota)

    {:ok, socket}
  end
end
