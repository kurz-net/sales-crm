defmodule DashboardWeb.RebelLive.InformationLive.Index do
  use DashboardWeb, :live_view
  import Ecto.Query

  alias Dashboard.{Accounts, Entities, Repo}
  alias Dashboard.Entities.Project
  alias Dashboard.Sales.{Call, Documentation}

  @impl true
  def mount(_params, session, socket) do
    socket = socket
             |> fetch_current_user(session)
             |> assign(contacts: [])
             |> assign(project: nil)
             |> assign(contact: nil)
             |> assign(summary: nil)
             #|> seed

    {:ok, socket}
  end

  def seed(socket) do
    project = Entities.get_project!(0)
    contact = "Porsche"

    contacts = fetch_contacts(project)
    calls = fetch_calls(project, contact)
    summary = summarize_calls(calls)

    socket
    |> assign(project: project)
    |> assign(contacts: contacts)
    |> assign(contact: contact)
    |> assign(summary: summary)
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [projects: [:partner]])

    assign(socket, current_user: current_user)
  end

  @impl true
  def handle_event("form-change", %{"params" => %{"project" => ""}}, socket) do
    socket = socket
             |> assign(contacts: [])
             |> assign(summary: nil)
             |> assign(contact: nil)

    {:noreply, socket}
  end

  @impl true
  def handle_event("form-change", %{"params" => %{"project" => project_id, "contact" => ""}}, socket) do
    project = Entities.get_project!(project_id)
    contacts = fetch_contacts(project)

    socket = socket
             |> assign(contacts: contacts)
             |> assign(project: project)

    {:noreply, socket}
  end

  @impl true
  def handle_event("form-change", %{"params" => %{"project" => project_id, "contact" => contact_name}}, %{assigns: %{project: prev_project}} = socket) do
    project = Entities.get_project!(project_id)

    project_id = String.to_integer(project_id)

    {contacts, contact, summary} = if project_id != prev_project.id do
      {[], nil, nil}
    else
      contacts = fetch_contacts(project)
      calls = fetch_calls(project, contact_name)
      summary = summarize_calls(calls)

      {contacts, contact_name, summary}
    end

    socket = socket
             |> assign(project: project)
             |> assign(contacts: contacts)
             |> assign(contact: contact)
             |> assign(summary: summary)

    {:noreply, socket}
  end

  defp contacts_query(project) do
    from c in Call,
      join: d in Documentation,
      on: d.call_id == c.id,
      where: c.project_id == ^project.id
  end

  defp fetch_contacts(%Project{} = project) do
    contacts_query(project)
    |> Repo.all
    |> Enum.map(fn c -> c.contact_name end)
    |> Enum.uniq
  end

  defp fetch_calls(%Project{} = project, contact_name) do
    query = from c in contacts_query(project),
            preload: [:documentation],
            where: c.contact_name == ^contact_name

    query
    |> Repo.all
  end

  defp summarize_calls(calls) do
    {disc, branche} = calls
                      |> Enum.map(&({&1.documentation.disc, &1.documentation.branche}))
                      |> Enum.uniq
                      |> Enum.at(0)

    data = calls
            |> Enum.filter(fn c -> c.documentation.data not in [nil, ""] end)
            |> Enum.map(&({&1.inserted_at, &1.documentation.data}))

    pains = calls
            |> Enum.filter(fn c -> c.documentation.pains not in [nil, ""] end)
            |> Enum.map(&({&1.inserted_at, &1.documentation.pains}))

    other = calls
            |> Enum.filter(fn c -> c.documentation.other not in [nil, ""] end)
            |> Enum.map(&({&1.inserted_at, &1.documentation.other}))

    outcomes = calls
               |> Enum.filter(fn c -> c.outcome not in [nil, ""] end)
               |> Enum.map(&({&1.inserted_at, &1.outcome}))

    follow_ups = calls
                 |> Enum.filter(fn c -> c.follow_up != nil end)
                 |> Enum.map(&(NaiveDateTime.to_string(&1.follow_up)))

    %{
      amount_calls: length(calls),
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
        <div class="text-xl font-semibold text-gray-800">
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
