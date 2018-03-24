use Mix.Config

config :core, GithubTags.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "github_tags_dev",
  hostname: "localhost",
  pool_size: 10
