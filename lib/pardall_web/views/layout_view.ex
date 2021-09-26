defmodule PardallWeb.LayoutView do
  use PardallWeb, :view

  def seo_tags(assigns) do
    module = assigns.conn.private.phoenix_live_view |> elem(0)
    PardallWeb.SEO.meta(assigns.conn, module, assigns)
  end
end
