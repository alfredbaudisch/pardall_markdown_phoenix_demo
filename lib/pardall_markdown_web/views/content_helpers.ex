defmodule PardallMarkdownWeb.ContentHelpers do
  use Phoenix.HTML
  use Phoenix.Component

  def format_date(%DateTime{} = date), do: date |> Calendar.strftime("%B %d, %Y")
end
