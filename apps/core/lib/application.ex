defmodule GithubTags.Core.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(GithubTags.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: GithubTags.Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
