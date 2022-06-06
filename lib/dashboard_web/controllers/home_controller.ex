defmodule DashboardWeb.HomeController do
  use DashboardWeb, :controller

  alias Dashboard.Accounts

  def new(conn, _), do: action(conn)
  def show(conn, _), do: action(conn)

  defp action(conn) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> redirect(to: "/")
      user_id ->
        user = Accounts.get_user!(user_id)

        path = case user.role do
          "rebel" -> "/rebel"
          "partner" -> "/partner"
          "saleup" -> "/saleup"
        end

        conn
        |> redirect(to: path)
    end
  end
end
