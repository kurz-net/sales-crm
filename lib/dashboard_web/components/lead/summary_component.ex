defmodule DashboardWeb.Components.Lead.SummaryComponent do
  use DashboardWeb, :live_component

  alias Dashboard.Repo

  @impl true
  def update(assigns, socket) do
    summary = assigns.lead
              |> Repo.preload(calls: [:documentation])
              |> summarize_calls

    socket = socket
             |> assign(assigns)
             |> assign(summary: summary)

    {:ok, socket}
  end

  defp summarize_calls(lead) do
    first_call = lead.calls
                 |> Enum.map(&({&1.documentation.disc, &1.documentation.branche}))
                 |> Enum.uniq
                 |> Enum.at(0)

    {disc, branche} = case first_call do
      nil -> {"", ""}
      {disc, branche} -> {disc, branche}
    end

    data = lead.calls
            |> Enum.filter(fn c -> c.documentation.data not in [nil, ""] end)
            |> Enum.map(&({&1.inserted_at, &1.documentation.data}))

    pains = lead.calls
            |> Enum.filter(fn c -> c.documentation.pains not in [nil, ""] end)
            |> Enum.map(&({&1.inserted_at, &1.documentation.pains}))

    other = lead.calls
            |> Enum.filter(fn c -> c.documentation.other not in [nil, ""] end)
            |> Enum.map(&({&1.inserted_at, &1.documentation.other}))

    outcomes = lead.calls
               |> Enum.filter(fn c -> c.outcome not in [nil, ""] end)
               |> Enum.map(&({&1.inserted_at, &1.outcome}))

    follow_ups = lead.calls
                 |> Enum.filter(fn c -> c.follow_up != nil end)
                 |> Enum.map(&(NaiveDateTime.to_string(&1.follow_up)))

    %{
      disc: disc,
      branche: branche,
      data: data,
      pains: pains,
      other: other,
      outcomes: outcomes,
      follow_ups: follow_ups
    }
  end

  defp display_section(header, list) do
    assigns = %{header: header, list: list}

    ~L"""
    <div class="mb-8 w-full lg:w-1/2">
      <div class="mb-2">
        <div class="text-lg font-semibold text-gray-800">
          <%= header %>
        </div>
      </div>
      <%= if length(@list) == 0 do %>
        <span class="italic font-medium text-gray-600">Nicht vorhanden</span>
      <% end %>
      <%= for item <- @list do %>
          <div class="mb-2">
          <%= case item do %>
            <%= {date, data} -> %>
              <div class="text-sm font-medium text-gray-600"><%= date %></div>
              <%= textualize data %>
            <%= _ -> %>
              <%= item %><br>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end
end
