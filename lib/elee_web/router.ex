defmodule EleeWeb.Router do
  use EleeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EleeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EleeWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/mobile", FoodLive.Index, :index
    live "/mobile/new", FoodLive.Index, :new
    live "/mobile/:id/edit", FoodLive.Index, :edit

    live "/mobile/:id", FoodLive.Show, :show
    live "/mobile/:id/show/edit", FoodLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", EleeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:elee, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EleeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
