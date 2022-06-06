defmodule DashboardWeb.PartnerLive.CreditLive.New do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Finance, Sales, Accounts}
  alias Dashboard.Finance.RebelCredit

  def mount(%{"id" => call_id}, session, socket) do
    changeset = %RebelCredit{}
                |> Finance.change_rebel_credit

    call = Sales.get_call!(call_id)
           |> Repo.preload(lead: [project: [:packets]])

    socket = socket
             |> fetch_current_user(session)
             |> assign(changeset: changeset)
             |> assign(call: call)

    {:ok, socket}
  end

  defp fetch_current_user(socket, %{"user_id" => user_id}) do
    current_user = Accounts.get_user!(user_id)
                   |> Repo.preload(:partner)

    assign(socket, current_user: current_user)
  end

  def handle_event("validate_credit", %{"rebel_credit" => params}, socket) do
    changeset = %RebelCredit{}
                |> Finance.change_rebel_credit(params)
                |> Map.put(:action, :insert)

    IO.inspect changeset

    socket = socket
             |> assign(changeset: changeset)

    {:noreply, socket}
  end

  def handle_event("add_pay_rate", _params, %{assigns: %{changeset: changeset}} = socket) do
    socket = if Ecto.Changeset.get_field(changeset, :packet_id) do
      pay_rates = Ecto.Changeset.get_field(changeset, :pay_rates)
                  |> Enum.map(&Map.from_struct/1)

      packet = case Map.get(changeset.changes, :packet_id) do
        nil -> nil
        packet_id -> Finance.get_packet!(packet_id)
      end

      value = if packet do
        packet.cost - RebelCredit.sum_pay_rates(packet, pay_rates)
      else
        0
      end

      new_pay_rate = %{
        date: Date.utc_today,
        percentage: false,
        value: value
      }

      pay_rates = pay_rates ++ [new_pay_rate]

      new_changeset = %RebelCredit{}
                  |> Finance.change_rebel_credit(%{
                    pay_rates: pay_rates
                  })
                  |> Map.put(:action, :insert)

      changeset = changeset
                  |> Ecto.Changeset.merge(new_changeset)

      socket
      |> assign(changeset: changeset)
    else
      socket
      |> clear_flash
      |> put_flash(:error, "Ein Packet muss zuerst ausgewählt werden")
    end

    {:noreply, socket}
  end

  def handle_event("remove_pay_rate", %{"index" => index}, %{assigns: %{changeset: changeset}} = socket) do
    index = String.to_integer(index)

    pay_rates = Ecto.Changeset.get_field(changeset, :pay_rates)
                |> Enum.map(&Map.from_struct/1)
                |> List.delete_at(index)

    new_changeset = %RebelCredit{}
                |> Finance.change_rebel_credit(%{
                  pay_rates: pay_rates
                })
                |> Map.put(:action, :insert)

    changeset = changeset
                |> Ecto.Changeset.delete_change(:pay_rates)
                |> Ecto.Changeset.merge(new_changeset)

    socket = socket
             |> assign(changeset: changeset)

    {:noreply, socket}
  end

  def handle_event("submit", %{"rebel_credit" => params}, %{assigns: %{call: call}} = socket) do
    params = Map.put(params, "call_id", call.id)
    params = Map.update!(params, "pay_rates", &Map.values/1)

    socket = case Finance.create_rebel_credit(params) do
      {:ok, _} ->
        socket
        |> clear_flash
        |> put_flash(:success, "Credit wurde erfolgreich erstelle!")
        |> redirect(to: "/partner")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end
end
