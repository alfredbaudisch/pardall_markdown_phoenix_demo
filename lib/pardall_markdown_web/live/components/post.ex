defmodule PardallMarkdownWeb.Live.PostComponents do
  use Phoenix.Component
  use Phoenix.HTML
  import PardallMarkdownWeb.ContentHelpers
  import PardallMarkdownWeb.PardallMarkdownHelpers

  def card(assigns) do
    ~H"""
    <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
      <div class="col p-4 d-flex flex-column position-static">
        <nav class="d-inline-block mb-2 text-primary crumbs post-card-taxonomies"><%= raw taxonomy_tree_list(@content.taxonomies) %></nav>
        <h4 class="mb-0"><%= @content.title %></h4>
        <div class="mb-1 text-muted"><%= format_date(@content.date) %></div>
        <p class="card-text mb-auto">
          <%= raw @content.summary %>
        </p>
        <%= live_redirect "View content", to: @content.slug, class: "stretched-link" %>
      </div>
      <%= if(not is_nil(Map.get(@content.metadata, :thumbnail))) do %>
      <div class="col-auto col-md-6 col-lg-4 d-md-inline-block d-lg-block">
        <img src={@content.metadata.thumbnail} class="img-fluid"/>
      </div>
      <% end %>
    </div>
    """
  end
end
