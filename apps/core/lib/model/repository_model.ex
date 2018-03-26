defmodule GithubTags.Model.Repository do
  @moduledoc """
  Helper Module to interact with Repository Schema and Database
  """

  alias GithubTags.Repo

  alias GithubTags.Schemas.Repository, as: RepositorySchema
  alias GithubTags.Model.User

  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset, only: [change: 1, put_change: 3]

  @repo_not_found "repository not found"
  @user_not_found "user not found"

  @doc """
  Populate or update repositories for a given username

  ##Example
      iex()> GithubTags.Model.Repository.populate_or_update_repositories("mbenatti")
      :ok
  """
  @spec populate_or_update_repositories(String.t()) :: :ok
  def populate_or_update_repositories(username) do
    case User.get_user(username) do
      nil ->
        @user_not_found

      _user ->
        github_request(username)
        |> Task.async_stream(fn repository ->
          add_or_update(username, %{
            "name" => repository["name"],
            "description" => repository["description"],
            "language" => repository["language"],
            "html_url" => repository["html_url"]
          })
        end)
        |> Stream.run()
    end
  end

  defp github_request(username) do
    case Tentacat.Users.Starring.starred(username, Tentacat.Client.new()) do
      {404, _} -> []
      result -> result
    end
  end

  defp add_or_update(username, %{
         "name" => name,
         "description" => desc,
         "language" => lang,
         "html_url" => url
       }) do
    case get_by_url(username, url) do
      nil -> %RepositorySchema{user: username}
      repository -> repository
    end
    |> RepositorySchema.changeset(%{
      "name" => name,
      "description" => desc,
      "language" => lang,
      "url" => url
    })
    |> Repo.insert_or_update()
  end

  @doc """
  Get all repositories by username
  """
  @spec get_by_user(String.t()) :: [RepositorySchema.t()] | []
  def get_by_user(username) do
    from(r in RepositorySchema, where: r.user == ^username)
    |> Repo.all()
  end

  def get_by_tag(username, tag) do
    from(r in RepositorySchema, where: r.user == ^username and ^tag in r.tags)
    |> Repo.all()
  end

  @doc """
  Get all existing repositories
  """
  @spec get_all() :: [RepositorySchema.t()] | []
  def get_all() do
    Repo.all(RepositorySchema)
  end

  @doc """
  Get a User repository by url
  """
  @spec get_by_url(String.t(), String.t()) :: RepositorySchema.t() | nil
  def get_by_url(username, repository_url) do
    Repo.get_by(RepositorySchema, user: username, url: repository_url)
  end

  @doc """
  Add a tag
  """
  @spec add_tag(String.t(), Integer.t(), String.t()) :: String.t() | {:ok, RepositorySchema.t()}
  def add_tag(username, repository_id, tag) do
    case Repo.get_by(RepositorySchema, user: username, id: repository_id) do
      nil ->
        @repo_not_found

      repository ->
        add_tag(repository, tag)
    end
  end

  @doc """
  Add a tag by repository url
  """
  @spec add_tag_by_url(String.t(), String.t(), String.t()) ::
          String.t() | {:ok, RepositorySchema.t()}
  def add_tag_by_url(username, repository_url, tag) do
    case get_by_url(username, repository_url) do
      nil ->
        @repo_not_found

      repository ->
        add_tag(repository, tag)
    end
  end

  defp add_tag(repository, tag) do
    case repository.tags do
      nil ->
        repository
        |> change()
        |> put_change(:tags, [tag])
        |> Repo.update()

      tags ->
        if !Enum.member?(tags, tag) do
          repository
          |> change()
          |> put_change(:tags, [tag | tags])
          |> Repo.update()
        else
          {:ok, repository}
        end
    end
  end

  @doc """
  Remove a tag by repository url
  """
  @spec remove_tag(String.t(), String.t(), String.t()) :: String.t() | {:ok, RepositorySchema.t()}
  def remove_tag(username, repository_url, tag) do
    repository = get_by_url(username, repository_url)

    if !is_nil(repository) do
      case repository.tags do
        nil ->
          @repo_not_found

        _tags ->
          remove_tag(repository, tag)
      end
    else
      @repo_not_found
    end
  end

  defp remove_tag(repository, tag) do
    new_tag_list = List.delete(repository.tags, tag)

    repository
    |> change()
    |> put_change(:tags, new_tag_list)
    |> Repo.update()
  end
end
