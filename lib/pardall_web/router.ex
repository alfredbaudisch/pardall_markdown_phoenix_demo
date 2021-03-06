defmodule PardallWeb.Router do
  use PardallWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PardallWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(PardallWeb.PlugRedirectTrailingSlash, :without)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

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
      live_dashboard "/dashboard", metrics: PardallWeb.Telemetry
    end
  end

  scope "/", PardallWeb do
    pipe_through :browser

    live "/", Live.Index, :index, container: {:main, class: "container main-container"}

    live "/categories", Live.Index, :taxonomy_tree,
      container: {:main, class: "container main-container"}

    live "/sitemap", Live.Index, :content_tree,
      container: {:main, class: "container main-container"}

    live "/*slug", Live.Content, :show,
      container: {:main, class: "container-fluid main-container"}
  end

  # Other scopes may use custom stacks.
  # scope "/api", PardallWeb do
  #   pipe_through :api
  # end
end
