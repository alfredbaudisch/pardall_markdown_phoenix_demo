defmodule PardallWeb.SEO do
  use PardallWeb, :view
  alias PardallWeb.SEO.{Generic, OpenGraph}
  alias PardallMarkdown.Content.Post

  @default_assigns %{canonical_url: nil, site: %Generic{}, og: nil, page_title: nil}

  def meta(conn, PardallWeb.Live.Content, %{live_content: %Post{} = post}) do
    render(
      "meta.html",
      @default_assigns
      |> put_page_title(conn)
      |> put_canonical(conn, post)
      |> put_opengraph_tags(conn, post)
    )
  end

  def meta(conn, _, _assigns),
    do: render("meta.html", @default_assigns |> put_canonical(conn, nil))

  def put_page_title(assigns, %{assigns: %{page_title: page_title}}), do:
    Map.put(assigns, :page_title, page_title)

  def put_canonical(assigns, _conn, %{original_url: url}) when url not in ["", nil],
    do: Map.put(assigns, :canonical_url, url)

  def put_canonical(assigns, conn, _post),
    do: Map.put(assigns, :canonical_url, PardallWeb.Endpoint.static_url() <> Phoenix.Controller.current_path(conn))

  def put_opengraph_tags(assigns, conn, post),
    do: Map.put(assigns, :og, OpenGraph.build(conn, post))
end
