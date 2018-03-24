use Mix.Config

config :core, GithubTags.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "github_tags_prod",
  hostname: "localhost",
  pool_size: 30,
  timeout: 30_000
