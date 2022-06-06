defmodule DashboardWeb.RegisterLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.Entities
  alias Dashboard.Entities.Rebel

  @impl true
  def mount(_params, _session, socket) do
    changeset = %Rebel{}
                |> Entities.change_register_rebel

    socket = socket
             |> assign(changeset: changeset)

    {:ok, socket}
  end

  @impl true
  def handle_event("submit", %{"rebel" => rebel}, socket) do
    socket = case Entities.register_rebel(rebel) do
      {:ok, user} ->
        IO.inspect user
        socket
        |> clear_flash
        |> put_flash(:success, "Erfolgreich Registriert!")
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end
end
