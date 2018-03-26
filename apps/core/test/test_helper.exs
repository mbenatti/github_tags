ExUnit.start()

Ecto.Adapters.SQL.Sandbox.checkout(GithubTags.Repo)
Ecto.Adapters.SQL.Sandbox.mode(GithubTags.Repo, {:shared, self()})

