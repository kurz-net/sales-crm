defmodule DashboardWeb.SaleupLive.RebelsLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.{Repo, Accounts, Entities}
  alias Dashboard.Accounts.ActivationCode

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user!(user_id)

    rebels = Entities.list_rebels

    socket = socket
             |> assign(current_user: current_user)
             |> assign(rebels: rebels)
             |> gen_activation_code

    {:ok, socket}
  end

  defp gen_activation_code(socket) do
    length = 12
    code = :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)

    Accounts.create_activation_code(%{
      code: code
    })

    socket
    |> assign(activation_code: code)
  end

  @impl true
  def handle_event("refresh_code", _, socket) do
    socket = socket
             |> gen_activation_code

    {:noreply, socket}
  end

  @impl true
  def handle_event("deactivate_code", %{"code" => code}, socket) do
    socket = case Repo.get_by(ActivationCode, code: code) do
      %ActivationCode{} = activation_code ->
        Accounts.delete_activation_code(activation_code)
        socket
        |> clear_flash
        |> put_flash(:success, "Code wurde erfolgreich invalidiert")
      nil ->
        socket
        |> clear_flash
        |> put_flash(:error, "Ungültiger Code")
    end

    {:noreply, socket}
  end
end
