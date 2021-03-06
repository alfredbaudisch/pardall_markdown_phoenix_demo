defmodule PardallWeb.Utils do
  @site_name Application.compile_env!(:pardall_web, [PardallMarkdown.Content, :site_name])

  def compose_page_title(title), do: title <> " | " <> site_name()

  def site_name, do: @site_name
end
