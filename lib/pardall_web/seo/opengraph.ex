defmodule PardallWeb.SEO.OpenGraph do
  @moduledoc """
  Build OpenGraph tags. This is destined for Facebook, Twitter, and Slack.

  https://developers.facebook.com/docs/sharing/webmasters/
  https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/markup
  https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/abouts-cards
  https://api.slack.com/reference/messaging/link-unfurling#classic_unfurl

  @source https://github.com/dbernheisel/bernheisel.com
  """

  alias PardallWeb.Router.Helpers, as: Routes
  alias PardallMarkdown.Content.Post

  @endpoint PardallWeb.Endpoint
  @generic %PardallWeb.SEO.Generic{}

  defstruct [
    :description,
    :expires_at,
    :image_alt,
    :image_url,
    :published_at,
    :reading_time,
    :title,
    :url,
    article_section: "Wiki",
    # site = twitter handle representing the overall site.
    locale: "en_US",
    site: "@alfredbaudisch",
    site_title: @generic.title,
    twitter_handle: "@alfredbaudisch",
    type: "website"
  ]

  def build(conn, %Post{} = post) do
    %__MODULE__{
      url: Phoenix.Controller.current_url(conn),
      title: truncate(post.title, 70),
      type: "article",
      published_at: format_date(post.date),
      description: post.summary
    }
    |> put_image(post)
  end

  defp put_image(og, %{metadata: %{thumbnail: thumbnail}} = post) when not is_nil(thumbnail), do:
    %{og | image_url: Routes.static_url(@endpoint, thumbnail), image_alt: post.title}

  defp put_image(og, _), do: og

  defp truncate(string, length) do
    if String.length(string) <= length do
      string
    else
      String.slice(string, 0..length)
    end
  end

  defp format_date(date), do: Date.to_iso8601(date)
end
