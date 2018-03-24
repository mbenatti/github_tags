use Mix.Config

config :core, :ecto_repos, [GithubTags.Repo]

import_config "#{Mix.env}.exs"
