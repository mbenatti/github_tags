defmodule GithubTags.Schemas.User do
  @moduledoc"""
  User Schema representing the 'users' Table in DB
  """

  use Ecto.Schema

  @primary_key {:username, :string, []}
  @derive {Phoenix.Param, key: :username}
  schema "users" do
    has_many :repositories, GithubTags.Schemas.Repository

    timestamps()
  end
end
