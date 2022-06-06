defmodule DashboardWeb.SaleupLive.Requirements.New do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Sales, Entities}
  alias Dashboard.Sales.PerformanceRequirement

  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    changeset = %PerformanceRequirement{}
                |> Sales.change_performance_requirement

    partners = Entities.list_partners

    socket = socket
             |> assign(current_user: current_user)
             |> assign(changeset: changeset)
             |> assign(partners: partners)
             |> assign(rebels: [])

    {:ok, socket}
  end

  def handle_event("update_rebels", %{"performance_requirement" => params}, socket) do
    rebels = if params["partner_id"] != "" do
      partner_id = String.to_integer(params["partner_id"])

      Entities.list_rebels
      |> Repo.preload(projects: [:partner])
      |> Enum.filter(fn rebel ->
        Enum.any?(rebel.projects, fn project ->
          project.partner.id == partner_id
        end)
      end)
    else
      []
    end

    changeset = %PerformanceRequirement{}
                |> Sales.change_performance_requirement(params)
                |> Map.put(:action, :insert)

    socket = socket
             |> assign(changeset: changeset)
             |> assign(rebels: rebels)

    {:noreply, socket}
  end

  def handle_event("submit_requirement", %{"performance_requirement" => performance_requirement}, socket) do
    IO.inspect performance_requirement

    socket = case Sales.create_performance_requirement(performance_requirement) do
      {:ok, requirement} ->
        IO.inspect requirement
        socket
        |> clear_flash
        |> put_flash(:success, "Successfully created requirement!")
        |> assign(rebels: [])

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end

  def start_week do
    today = Date.utc_today
    week_day = Date.day_of_week(today)
    today
    |> Date.add(-week_day+1)
  end

  def end_week do
    today = Date.utc_today
    week_day = Date.day_of_week(today)
    today
    |> Date.add(7-week_day)
  end
end
