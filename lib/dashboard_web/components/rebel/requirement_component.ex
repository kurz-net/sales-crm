defmodule DashboardWeb.RequirementComponent do
  use DashboardWeb, :live_component

  alias Dashboard.{Repo, Sales, Entities}

  def update(assigns, socket) do
    rebel = assigns.rebel

    calls = Entities.get_rebel_calls(rebel)
            |> Repo.preload([lead: [project: [:partner]]])

    socket = socket
             |> assign(assigns)
             |> assign(rebel: rebel)
             |> assign(calls: calls)

    {:ok, socket}
  end

  defp number_calls(rebel, requirement) do
    requirement.partner.projects
    |> Enum.flat_map(fn p -> p.leads end)
    |> Enum.flat_map(fn l -> l.calls end)
    |> Enum.filter(fn call -> call.lead.rebel_id == rebel.id end)
    |> Enum.count
  end
  defp percentage_calls(rebel, requirement) do
    number = number_calls(rebel, requirement)
    number / requirement.calls * 100
  end

  defp number_hours(calls, requirement) do
    sum = calls
          |> Enum.filter(fn call ->
            call.project.partner.id == requirement.partner.id
          end)
          |> Enum.map(fn call -> call.length end)
          |> Enum.sum

    result = sum / 60 / 60

    Float.round(result, 2)
  end
  defp formatted_hours(calls, requirement) do
    number = number_hours(calls, requirement)
    full_hours = trunc(number)
    minutes = trunc((number - full_hours) * 60)

    hours_string = clock_number(full_hours)
    minutes_string = clock_number(minutes)

    "#{hours_string}:#{minutes_string}"
  end
  defp percentage_hours(calls, requirement) do
    number = number_hours(calls, requirement)
    result = number / requirement.hours * 100

    Float.round(result)
  end

  defp clock_number(int) do
    if int < 10 do
      "0#{int}"
    else
      Integer.to_string(int)
    end
  end
end
