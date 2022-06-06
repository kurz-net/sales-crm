defmodule DashboardWeb.RebelLive.WorkQuotaLive.Edit do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Metrics}

  def mount(%{"id" => work_quota_id}, session, socket) do
    work_quota = Metrics.get_rebel_work_quota!(work_quota_id)

    changeset = work_quota
                |> Metrics.change_rebel_work_quota

    socket = socket
             |> fetch_current_user(session)
             |> assign(work_quota: work_quota)
             |> assign(changeset: changeset)

    {:ok, socket}
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [:calls, projects: [:partner]])

    assign(socket, current_user: current_user)
  end

  def handle_event("submit_work_quota", %{"rebel_work_quota" => params}, %{assigns: %{current_user: current_user, work_quota: work_quota}} = socket) do
    params = Map.put(params, "rebel_id", current_user.rebel.id)

    socket = case Metrics.update_rebel_work_quota(work_quota, params) do
      {:ok, work_quota} ->
        IO.inspect work_quota
        socket
        |> clear_flash
        |> put_flash(:success, "Pensum wurde erfolgreich bearbeitet!")
        |> redirect(to: "/rebel")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end
end
