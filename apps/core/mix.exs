defmodule GithubTags.Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GithubTags.Core.Application, []}
    ]
  end

  defp deps do
    [
      {:tentacat, "~> 0.8.0"},
      {:postgrex, "~> 0.13.5"},
      {:ecto, "~> 2.2"}
    ]
  end
end