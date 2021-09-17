defmodule PardallMarkdownWeb.Live.Content do
  use PardallMarkdownWeb, :live_view
  alias PardallMarkdown.Content.{Post, Link}
  alias PardallMarkdown.Repository

  def mount(%{"slug" => slug}, _session, socket) do
    slug = slug |> slug_params_to_slug()

    if connected?(socket) do
      Endpoint.subscribe("pardall_markdown_web")
    end

    {:ok, socket |> assign(:slug, slug) |> load_content()}
  end

  def render(%{content: %Post{}} = assigns),
    do:
      Phoenix.View.render(
        PardallMarkdownWeb.ContentView,
        "single_post_with_sidebar.html",
        assigns
      )

  def render(%{content: %Link{}} = assigns),
    do: Phoenix.View.render(PardallMarkdownWeb.ContentView, "single_taxonomy.html", assigns)

  def handle_info(%{event: "content_reloaded", payload: :all}, socket) do
    {:noreply, socket |> load_content()}
  end

  defp load_content(%{assigns: %{slug: slug}} = socket) do
    content = Repository.get_by_slug!(slug)

    socket
    |> assign(:content, content)
    |> assign_page_title(content)
    |> assign_content_tree(content)
  end

  defp slug_params_to_slug(slug), do: "/" <> Enum.join(slug, "/")

  defp assign_page_title(socket, %Post{title: title}),
    do: socket |> assign(:page_title, compose_page_title(title))

  defp assign_page_title(socket, %Link{title: title}),
    do: socket |> assign(:page_title, compose_page_title(title))

  defp assign_content_tree(socket, %Post{taxonomies: [root_tax | _]}) do
    socket
    |> assign(:content_tree, Repository.get_content_tree(root_tax.slug))
    |> assign(:top_taxonomy, root_tax)
  end

  defp assign_content_tree(socket, %Link{parents: [_ | [root_tax | _]]}) do
    topmost = Repository.get_by_slug!(root_tax)

    socket
    |> assign(:content_tree, Repository.get_content_tree(root_tax))
    |> assign(:top_taxonomy, topmost)
  end

  defp assign_content_tree(socket, %Link{slug: slug} = link) do
    socket
    |> assign(:content_tree, Repository.get_content_tree(slug))
    |> assign(:top_taxonomy, link)
  end
end
