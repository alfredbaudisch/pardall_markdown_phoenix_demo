defmodule PardallMarkdownWeb.PardallMarkdownHelpers do
  alias PardallMarkdown.Content.{Link, AnchorLink}
  use Phoenix.HTML
  import Phoenix.LiveView.Helpers

  def collapsible_taxonomy_tree_list(nil), do: nil

  def collapsible_taxonomy_tree_list(taxonomies), do: collapsible_taxonomy_tree(taxonomies)

  defp collapsible_taxonomy_tree(
         taxonomies,
         all \\ "<ul>",
         previous_level \\ -1,
         parent_level \\ 0
       )

  defp collapsible_taxonomy_tree([%Link{level: level} = taxonomy | tail], all, -1, parent_level) do
    collapsible_taxonomy_tree(
      tail,
      all <> "<li>" <> collapsible_taxonomy_link(taxonomy, tail, parent_level),
      level,
      parent_level
    )
  end

  defp collapsible_taxonomy_tree(
         [%Link{level: level} = taxonomy | tail],
         all,
         previous_level,
         parent_level
       )
       when level > previous_level do
    parent_level = parent_level + 1

    new_level = ~s"""
    <div class="collapse show" id="collapse-content-#{parent_level}">
    <ul class="ls-inner">
    <li>
    """

    # nest new level
    collapsible_taxonomy_tree(
      tail,
      all <> new_level <> collapsible_taxonomy_link(taxonomy, tail, parent_level),
      level,
      parent_level
    )
  end

  defp collapsible_taxonomy_tree(
         [%Link{level: level} = taxonomy | tail],
         all,
         previous_level,
         parent_level
       )
       when level < previous_level do
    # go up (previous_level - level) levels, closing nest(s)
    diff = previous_level - level
    close = String.duplicate("</ul></div></li>", diff)

    collapsible_taxonomy_tree(
      tail,
      all <> close <> "<li>" <> collapsible_taxonomy_link(taxonomy, tail, parent_level),
      level,
      parent_level
    )
  end

  defp collapsible_taxonomy_tree(
         [%Link{level: level} = taxonomy | tail],
         all,
         previous_level,
         parent_level
       )
       when level == previous_level do
    # same level
    collapsible_taxonomy_tree(
      tail,
      all <> "</li><li>" <> collapsible_taxonomy_link(taxonomy, tail, parent_level),
      level,
      parent_level
    )
  end

  # Empty initial list provided
  defp collapsible_taxonomy_tree([], "<ul>", _, _), do: ""

  # No more taxonomies to traverse, finish and return the list
  defp collapsible_taxonomy_tree([], all, previous_level, _parent_level),
    do: all <> String.duplicate("</li></ul>", previous_level) <> "</li></ul>"

  defp collapsible_taxonomy_link(
         %Link{title: title, slug: slug, level: level},
         [%Link{level: next_level} | _],
         parent_level
       )
       when next_level > level do
    live_link = live_redirect(title, to: slug) |> safe_to_string()
    controls_level = parent_level + 1

    ~s"""
    <div>
      <a class="collapsed btn-toggle" role="button" data-bs-toggle="collapse"
      data-bs-target="#collapse-content-#{controls_level}" aria-expanded="true" aria-controls="collapse-content-#{controls_level}"/>
      #{live_link}
    </div>
    """
  end

  defp collapsible_taxonomy_link(%Link{title: title, slug: slug}, _, _) do
    live_redirect(title, to: slug)
    |> safe_to_string()
  end

  @doc """
  Generates a HTML string of nested `<ul/>` lists of Taxonomies names,
  with LiveView links to the taxonomy slug.

  ## Example
  Input list of taxonomies:
  ```elixir
  [
    %PardallMarkdown.Link{level: 0, name: "Home", parents: ["/"], slug: "/"},
    %PardallMarkdown.Link{level: 0, name: "Blog", parents: ["/"], slug: "/blog"},
    %PardallMarkdown.Link{level: 1, name: "Art", parents: ["/", "/blog"], slug: "/blog/art"},
    %PardallMarkdown.Link{level: 2, name: "3D", parents: ["/", "/blog", "/blog/art"], slug: "/blog/art/3d"}
  ]
  ```

  The resulting HTML string:
  ```html
  <ul>
  <li><a data-phx-link="redirect" data-phx-link-state="push" href="/">Home</a></li>
  <li>
      <a data-phx-link="redirect" data-phx-link-state="push" href="/blog">Blog</a>
      <ul>
        <li>
            <a data-phx-link="redirect" data-phx-link-state="push" href="/blog/art">Art</a>
            <ul>
              <li><a data-phx-link="redirect" data-phx-link-state="push" href="/blog/art/3d">3D</a></li>
            </ul>
        </li>
      </ul>
  </li>
  </ul>
  ```
  """
  def taxonomy_tree_list(nil), do: nil

  def taxonomy_tree_list(taxonomies), do: taxonomy_tree(taxonomies)

  defp taxonomy_tree(taxonomies, all \\ "<ul>", previous_level \\ -1)

  defp taxonomy_tree([%Link{level: level} = taxonomy | tail], all, -1) do
    taxonomy_tree(tail, all <> "<li>" <> taxonomy_link(taxonomy), level)
  end

  defp taxonomy_tree([%Link{level: level} = taxonomy | tail], all, previous_level)
       when level > previous_level do
    # nest new level
    taxonomy_tree(tail, all <> "<ul><li>" <> taxonomy_link(taxonomy), level)
  end

  defp taxonomy_tree([%Link{level: level} = taxonomy | tail], all, previous_level)
       when level < previous_level do
    # go up (previous_level - level) levels, closing nest(s)
    diff = previous_level - level
    close = String.duplicate("</ul></li>", diff)

    taxonomy_tree(tail, all <> close <> "<li>" <> taxonomy_link(taxonomy), level)
  end

  defp taxonomy_tree([%Link{level: level} = taxonomy | tail], all, previous_level)
       when level == previous_level do
    # same level
    taxonomy_tree(tail, all <> "</li><li>" <> taxonomy_link(taxonomy), level)
  end

  # Empty initial list provided
  defp taxonomy_tree([], "<ul>", _), do: ""

  # No more taxonomies to traverse, finish and return the list
  defp taxonomy_tree([], all, previous_level),
    do: all <> String.duplicate("</li></ul>", previous_level) <> "</li></ul>"

  defp taxonomy_link(%Link{title: title, slug: slug}) do
    live_redirect(title, to: slug)
    |> safe_to_string()
  end

  def post_toc_list(nil), do: nil

  def post_toc_list(links), do: post_toc(links)

  defp post_toc(links, all \\ "<ul>", previous_level \\ -1)

  defp post_toc([%AnchorLink{level: level} = link | tail], all, -1) do
    post_toc(tail, all <> "<li>" <> toc_link(link), level)
  end

  defp post_toc([%AnchorLink{level: level} = link | tail], all, previous_level)
       when level > previous_level do
    # nest new level
    post_toc(tail, all <> "<ul><li>" <> toc_link(link), level)
  end

  defp post_toc([%AnchorLink{level: level} = link | tail], all, previous_level)
       when level < previous_level do
    # go up (previous_level - level) levels, closing nest(s)
    diff = previous_level - level
    close = String.duplicate("</ul></li>", diff)

    post_toc(tail, all <> close <> "<li>" <> toc_link(link), level)
  end

  defp post_toc([%AnchorLink{level: level} = link | tail], all, previous_level)
       when level == previous_level do
    # same level
    post_toc(tail, all <> "</li><li>" <> toc_link(link), level)
  end

  # Empty initial list provided
  defp post_toc([], "<ul>", _), do: ""

  # No more taxonomies to traverse, finish and return the list
  defp post_toc([], all, previous_level),
    do: all <> String.duplicate("</li></ul>", previous_level) <> "</li></ul>"

  defp toc_link(%AnchorLink{title: title, id: id}), do: "<a href=\"#{id}\">#{title}</a>"

  def has_next_or_previous_posts?(%{link: %{previous: previous, next: next}})
      when not is_nil(previous) or not is_nil(next),
      do: true

  def has_next_or_previous_posts?(_), do: false
end
