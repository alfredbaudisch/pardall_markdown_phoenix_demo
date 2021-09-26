defmodule PardallWeb.SEO.Generic do
  @moduledoc """
  This is generic SEO data for any search engine that isn't catered to any one feature.

  https://support.google.com/webmasters/answer/7451184?hl=en
  """

  @title Application.get_env(:pardall_web, PardallMarkdown.Content)[:site_name]
  @description Application.get_env(:pardall_web, PardallMarkdown.Content)[:site_description]

  defstruct description: @description,
            title: @title
end
