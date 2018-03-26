defmodule GithubTags.Model.User do
  @moduledoc """
  Helper Module to interact with User Schema and Database
  """

  alias GithubTags.Repo
  alias GithubTags.Schemas.User, as: UserSchema

  @doc """
  Get or create an User Create an User

  ## Examples

      iex()> GithubTags.Model.User.get_or_create_user("mbenatti")
      %GithubTags.Schemas.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        inserted_at: ~N[2018-03-24 23:00:08.962249],
        repositories: #Ecto.Association.NotLoaded<association :repositories is not loaded>,
        updated_at: ~N[2018-03-24 23:00:08.962274],
        username: "mbenatti"
      }

  """
  @spec get_or_create_user(String.t()) :: UserSchema.t()
  def get_or_create_user(username) do
    case Repo.get(UserSchema, username) do
      nil -> create_user(username)
      user -> user
    end
  end

  @doc """
  Get a user
  """
  @spec get_user(String.t()) :: UserSchema.t()
  def get_user(username) do
    Repo.get(UserSchema, username)
  end

  @doc """
  Get all users
  """
  @spec get_users() :: [UserSchema.t()]
  def get_users() do
    Repo.all(UserSchema)
  end

  @doc """
  Create an User Create na User
  """
  @spec create_user(String.t()) :: UserSchema.t() | {:error, UserSchema.Changeset.t()}
  def create_user(username) do
    case Repo.insert(%UserSchema{username: username}) do
      {:ok, schema} -> schema
      {:error, changeset} -> {:error, changeset}
    end
  end
end
