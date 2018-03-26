defmodule GithubTags.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  defp deps do
    [{:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}]
  end

  defp aliases do
    [
     "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test":       ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
