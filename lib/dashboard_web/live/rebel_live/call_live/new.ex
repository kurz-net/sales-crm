defmodule DashboardWeb.RebelLive.CallLive.New do
  use DashboardWeb, :live_view

  alias Dashboard.{Accounts, Repo, Sales}
  alias Dashboard.Sales.Call

  def mount(_params, session, socket) do
    socket = socket
             |> fetch_current_user(session)
             |> make_changeset
             |> init_call_tracking

    {:ok, socket}
  end

  def handle_params(%{"lead_id" => lead_id}, _url, socket) do
    changeset =
      %Call{
        lead_id: lead_id
      }
      |> Sales.change_call

    socket = socket
             |> assign(changeset: changeset)
             |> assign(lead_id: lead_id)

    {:noreply, socket}
  end

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  defp init_call_tracking(socket) do
    socket
    |> assign(running_call: false)
    |> assign(call_started: nil)
    |> assign(call_ended: nil)
  end

  defp make_changeset(socket) do
    changeset = %Call{}
                |> Sales.change_call

    socket
    |> assign(changeset: changeset)
    |> assign(contacts: [])
    |> assign(selected_project: false)
    |> assign(selected_contact: nil)
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(rebel: [:leads])

    assign(socket, current_user: current_user)
  end

  def handle_event("validate_call", %{"call" => call_params}, socket) do
    changeset = %Call{}
                |> Sales.change_call(call_params)
                |> Map.put(:action, :validate)

    socket = socket
             |> assign(changeset: changeset)

    {:noreply, socket}
  end
  def handle_event("submit_call", %{"call" => call}, %{assigns: %{current_user: current_user, call_started: call_started, call_ended: call_ended}} = socket) do
    length = if call_started do
      if call_ended do
        NaiveDateTime.diff(call_ended, call_started)
      else
        NaiveDateTime.diff(NaiveDateTime.utc_now, call_started)
      end
    else
      0
    end

    call = call
           |> Map.put("length", length)
           |> Map.put("rebel_id", current_user.rebel.id)

    call = if call["follow_up"]["hour"] == "0" and call["follow_up"]["minute"] == "0" do
      Map.delete(call, "follow_up")
    else
      call
    end

    socket = case Sales.create_call(call) do
      {:ok, call} ->
        IO.inspect call
        socket
        |> clear_flash
        |> put_flash(:success, "Anruf wurde eingetragen")
        |> assign(running_call: false)

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end

  def handle_event("start_call", _, socket) do
    socket = socket
             |> assign(running_call: true)
             |> assign(call_started: NaiveDateTime.utc_now)

    {:noreply, socket}
  end
  def handle_event("end_call", _, socket) do
    socket = socket
             |> assign(running_call: false)
             |> assign(call_ended: NaiveDateTime.utc_now)

    {:noreply, socket}
  end

  def handle_event("navigate_back", _params, socket) do
    socket = if is_nil(Map.get(socket.assigns, :lead_id)) do
      socket
      |> redirect(to: Routes.rebel_index_path(socket, :index))
    else
      socket
      |> redirect(to: Routes.rebel_leads_show_path(socket, :show, socket.assigns.lead_id))
    end

    {:noreply, socket}
  end
end
