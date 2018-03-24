defmodule GithubTags.Core.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: GithubTags.Core.Worker.start_link(arg)
      # {GithubTags.Core.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubTags.Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
