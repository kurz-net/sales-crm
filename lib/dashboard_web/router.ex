defmodule DashboardWeb.Router do
  use DashboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DashboardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DashboardWeb do
    pipe_through :browser

    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true

    live "/register", RegisterLive.Index
  end

  scope "/", DashboardWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/", HomeController, singleton: true
    resources "/home", HomeController, singleton: true
  end

  scope "/", DashboardWeb do
    pipe_through [:browser, :authenticate_user, :is_rebel]

    live "/rebel", RebelLive.Index, :index
    live "/rebel/export", RebelLive.Index, :export

    live "/rebel/information", RebelLive.InformationLive.Index
    live "/rebel/requirements", RebelLive.RequirementsLive.Index

    live "/rebel/leads", RebelLive.LeadsLive.Index, :index
    live "/rebel/leads/new", RebelLive.LeadsLive.New, :new
    live "/rebel/leads/:id/show", RebelLive.LeadsLive.Show, :show

    live "/rebel/calls/export", RebelLive.Index, :export
    live "/rebel/calls/new", RebelLive.CallLive.New
    live "/rebel/calls/:id/show", RebelLive.CallLive.Show, :show
    live "/rebel/calls/:id/show/export", RebelLive.CallLive.Show, :export

    live "/rebel/workquota/new", RebelLive.WorkQuotaLive.New
    live "/rebel/workquota/:id/edit", RebelLive.WorkQuotaLive.Edit
  end

  scope "/", DashboardWeb do
    pipe_through [:browser, :authenticate_user, :is_partner]

    live "/partner", PartnerLive.Index, :index
    live "/partner/credits/:id/new", PartnerLive.CreditLive.New, :new

    live "/partner/projects/:id/show", PartnerLive.ProjectLive.Show, :show
  end

  scope "/", DashboardWeb do
    pipe_through [:browser, :authenticate_user, :is_saleup]

    live "/saleup", SaleupLive.Index, :index

    live "/saleup/rebels", SaleupLive.RebelsLive.Index, :index
    live "/saleup/rebels/:id", SaleupLive.RebelsLive.Show, :show
    live "/saleup/partners", SaleupLive.PartnersLive.Index, :index
    live "/saleup/partners/new", SaleupLive.PartnersLive.New, :new
    live "/saleup/partners/:id", SaleupLive.PartnersLive.Show, :edit

    live "/saleup/projects/new/:id", SaleupLive.ProjectsLive.New, :new # id = partner id
    live "/saleup/projects/:id", SaleupLive.ProjectsLive.Show, :edit

    live "/saleup/leads", SaleupLive.LeadsLive.Index, :index
    live "/saleup/leads/new", SaleupLive.LeadsLive.New, :new
    live "/saleup/leads/:id", SaleupLive.LeadsLive.Show, :edit

    live "/saleup/requirements/new", SaleupLive.Requirements.New
  end

  def authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.clear_flash
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/sessions/new")
      user_id ->
        assign(conn, :current_user, Dashboard.Accounts.get_user!(user_id))
    end
  end

  defp is_rebel(conn, _), do: is_role("rebel", conn)
  defp is_partner(conn, _), do: is_role("partner", conn)
  defp is_saleup(conn, _), do: is_role("saleup", conn)

  defp is_role(role, %{assigns: %{current_user: current_user}} = conn) do
    if current_user.role == role do
      conn
    else
      conn
      |> Phoenix.Controller.clear_flash
      |> Phoenix.Controller.put_flash(:error, "Must be a user of type #{role} to access this page")
      |> Phoenix.Controller.redirect(to: "/")
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DashboardWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DashboardWeb.Telemetry
    end
  end
end
