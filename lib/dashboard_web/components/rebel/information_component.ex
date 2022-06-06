defmodule DashboardWeb.InformationComponent do
  use DashboardWeb, :live_component

  alias Dashboard.{Repo, Entities}

  def update(assigns, socket) do
    rebel = assigns.rebel

    calls = Entities.get_rebel_calls(rebel)

    call_dates = calls
                 |> Enum.map(fn call ->
                   call.inserted_at
                   |> NaiveDateTime.to_date
                 end)

    calls_today = call_dates
                  |> Enum.filter(fn date ->
                    diff = date
                           |> Date.diff(Date.utc_today)
                    diff == 0
                  end)
                  |> length

    today = Date.utc_today
    week_day = Date.day_of_week(today)
    week_beginning = today
                     |> Date.add(-week_day+1)

    calls_week = call_dates
                  |> Enum.filter(fn date ->
                    diff = date
                           |> Date.diff(week_beginning)
                    diff >= 0
                  end)
                  |> length

    socket = socket
             |> assign(rebel: rebel)
             |> assign(calls_today: calls_today)
             |> assign(calls_week: calls_week)

    {:ok, socket}
  end
end
