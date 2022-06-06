defmodule DashboardWeb.SessionController do
  use DashboardWeb, :controller

  alias Dashboard.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.verify_user(%{email: email, password: password}) do
      {:error, _} ->
        conn
        |> clear_flash
        |> put_flash(:error, "Invalid Credentials")
        |> redirect(to: Routes.session_path(conn, :new))
      {:ok, user} ->
        path = case user.role do
          "rebel" -> "/rebel"
          "partner" -> "/partner"
          "saleup" -> "/saleup"
        end

        conn
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: path)
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/sessions/new")
  end
end
