defmodule PardallWeb.Live.Index do
  use PardallWeb, :live_view
  alias PardallMarkdown.Repository

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe("pardall_web")
    end

    {:ok, socket |> load_content()}
  end

  defp load_content(socket) do
    taxonomy_tree = Repository.get_taxonomy_tree()

    # Getting topmost taxonomies in order to build a main menu
    sections = Enum.filter(taxonomy_tree, &(&1.level == 0))

    socket
    |> assign(
      posts: Repository.get_all_published() |> sort_by_published_date(),
      content_tree: Repository.get_content_tree(),
      taxonomy_tree: taxonomy_tree,
      sections: sections
    )
    |> assign_page_title()
  end

  @impl true
  def handle_info(%{event: "content_reloaded", payload: _}, socket) do
    {:noreply, socket |> load_content()}
  end

  defp assign_page_title(%{assigns: %{live_action: :taxonomy_tree}} = socket),
    do: socket |> assign(:page_title, "Categories | " <> site_name())

  defp assign_page_title(%{assigns: %{live_action: :content_tree}} = socket),
    do: socket |> assign(:page_title, "Sitemap | " <> site_name())

  defp assign_page_title(socket),
    do: socket |> assign(:page_title, site_name())
end
