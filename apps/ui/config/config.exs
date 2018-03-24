# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ui,
  namespace: GithubTags.UI,
  ecto_repos: [GithubTags.UI.Repo]

# Configures the endpoint
config :ui, GithubTags.UIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vi8DDGRXfepOIOj/JFLzUe5RaM5elAuLqMetPAROY+OqlD5LQxC3AKvC4FohWDsP",
  render_errors: [view: GithubTags.UIWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GithubTags.UI.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"