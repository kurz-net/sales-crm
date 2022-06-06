defmodule DashboardWeb.RebelLive.WorkQuotaLive.New do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Metrics}
  alias Dashboard.Metrics.RebelWorkQuota

  def mount(_params, session, socket) do
    socket = socket
             |> fetch_current_user(session)
             |> make_changeset

    {:ok, socket}
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(:rebel)

    assign(socket, current_user: current_user)
  end

  defp make_changeset(socket) do
    changeset = %RebelWorkQuota{}
                |> Metrics.change_rebel_work_quota

    socket
    |> assign(changeset: changeset)
  end

  def handle_event("submit_work_quota", %{"rebel_work_quota" => params}, %{assigns: %{current_user: current_user}} = socket) do
    params = Map.put(params, "rebel_id", current_user.rebel.id)

    socket = case Metrics.create_rebel_work_quota(params) do
      {:ok, work_quota} ->
        IO.inspect work_quota
        socket
        |> clear_flash
        |> put_flash(:success, "Pensum wurde erfolgreich eingetragen!")
        |> redirect(to: "/rebel")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end

  defp start_week do
    today = Date.utc_today
    week_day = Date.day_of_week(today)
    today
    |> Date.add(-week_day+1)
  end

  defp end_week do
    today = Date.utc_today
    week_day = Date.day_of_week(today)
    today
    |> Date.add(7-week_day)
  end
end
