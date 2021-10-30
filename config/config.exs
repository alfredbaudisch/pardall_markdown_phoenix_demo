# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :pardall_web, PardallWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vlzywSsO+2L1dOf6SVsVn7VJPMJ/oyr10wH7jCLcNl++SAuXkPQ20t/qDSefGEgI",
  render_errors: [view: PardallWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PardallWeb.PubSub,
  live_view: [signing_salt: "5fx/EcCU"]

config :pardall_web, PardallMarkdown.Content,
  site_name: "PardallMarkdown",
  site_description: "Phoenix.LiveView website powered by reactive Markdown content with PardallMarkdown."


config :pardall_markdown, PardallMarkdown.Content,
  root_path: "./sample_content",
  static_assets_path: "./sample_content/static",
  remote_repository_url: "https://github.com/alfredbaudisch/pardall_markdown_sample_content",
  recheck_pending_remote_events_interval: 15_000,
  cache_name: :content_cache,
  index_cache_name: :content_index_cache,
  recheck_pending_file_events_interval: 1_000,
  content_tree_display_home: false,
  convert_internal_links_to_live_links: true,
  notify_content_reloaded: &PardallWeb.pardall_markdown_notifier/0,
  is_markdown_metadata_required: true,
  is_content_draft_by_default: true,
  metadata_parser: PardallMarkdown.MetadataParser.ElixirMap

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :mfa]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :esbuild,
  version: "0.12.26",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
