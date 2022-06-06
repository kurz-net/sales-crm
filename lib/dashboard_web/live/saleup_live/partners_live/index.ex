defmodule DashboardWeb.SaleupLive.PartnersLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}
  alias Dashboard.Entities.Partner

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    partners = Entities.list_partners
               |> Repo.preload(projects: [:rebels])

    socket = socket
             |> assign(current_user: current_user)
             |> assign(partners: partners)

    {:ok, socket}
  end

  def amount_rebels(%Partner{} = partner) do
    partner.projects
    |> Enum.map(fn project -> length(project.rebels) end)
    |> Enum.sum
  end
end
