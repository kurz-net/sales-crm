defmodule DashboardWeb.PartnerFormComponent do
  use DashboardWeb, :live_component

  alias Dashboard.Entities

  @impl true
  def update(%{partner: partner} = assigns, socket) do
    changeset = Entities.change_partner(partner)

    socket = socket
             |> assign(assigns)
             |> assign(changeset: changeset)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"partner" => partner_params}, socket) do
    changeset =
      socket.assigns.partner
      |> Entities.change_partner(partner_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"partner" => partner_params}, socket) do
    save_user(socket, socket.assigns.action, partner_params)
  end

  defp save_user(socket, :edit, partner_params) do
    case Entities.update_partner(socket.assigns.partner, partner_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> clear_flash
         |> put_flash(:info, "Änderungen wurden gespeichert!")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user(socket, :new, partner_params) do
    case Entities.create_partner(partner_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> clear_flash
         |> put_flash(:info, "Partner wurde erstellt!")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
