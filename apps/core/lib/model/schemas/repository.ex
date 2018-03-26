defmodule GithubTags.Schemas.Repository do
  @moduledoc """
  Repository Schema representing the 'repositories' Table in DB
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "repositories" do
    field(:name, :string)
    field(:description, :string)
    field(:language, :string)
    field(:url, :string)

    field(:tags, {:array, :string})

    belongs_to(
      :user_username,
      GithubTags.Schemas.User,
      foreign_key: :user,
      references: :username,
      type: :string
    )

    timestamps()
  end

  @permitted ~w(url name description language tags)a
  @required ~w(url)a

  def changeset(repository, params \\ %{}) do
    repository
    |> cast(params, @permitted)
    |> validate_required(@required)
  end
end
