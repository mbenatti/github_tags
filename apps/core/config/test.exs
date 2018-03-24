use Mix.Config

config :core, GithubTags.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "github_tags_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
