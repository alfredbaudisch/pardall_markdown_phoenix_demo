defmodule PardallMarkdownWeb.Live.PostComponents do
  use Phoenix.Component
  use Phoenix.HTML
  import PardallMarkdownWeb.ContentHelpers

  def card(assigns) do
    ~H"""
    <div class={@col_class}>
      <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
        <div class="col p-4 d-flex flex-column position-static">
          <strong class="d-inline-block mb-2 text-primary"><%= List.last(@content.taxonomies).title %></strong>
          <h3 class="mb-0"><%= @content.title %></h3>
          <div class="mb-1 text-muted"><%= format_date(@content.date) %></div>
          <p class="card-text mb-auto">
            <%= raw @content.summary %>
          </p>
          <%= live_redirect "View content", to: @content.slug, class: "stretched-link" %>
        </div>
        <div class="col-auto col-md-6 col-lg-4 d-md-inline-block d-lg-block">
          <img src="/images/dog-thumb.jpg" class="img-fluid"/>
        </div>
      </div>
    </div>
    """
  end
end
