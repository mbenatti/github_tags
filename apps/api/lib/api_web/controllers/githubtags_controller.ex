defmodule GithubTags.APIWeb.GithubtagsController do
  @moduledoc """
  Module to handle with API routes
  """
  use GithubTags.APIWeb, :controller

  alias GithubTags.Model.User
  alias GithubTags.Model.Repository

  @doc """
  Create an user and insert the repositories into database(if github user was valid)

    params:
      - user: Github Username

  ## Examples
      $ curl -X PUT http://localhost:4002/api/create_user/mauriciomedeiros
      {"status":200,"message":"User created"}
  """
  def create_user(conn, %{"user" => username}) do
    User.get_or_create_user(username)
    Repository.populate_or_update_repositories(username)

    json(conn, %{status: 200, message: "User created"})
  end

  @doc """
  Get a repository by user

    params:
      - user: Github Username

  ## Examples
      $ curl -X GET http://localhost:4002/api/repositories/empty_or_invalid_user
      {"status":200,"result":[]}

      $ curl -X GET http://localhost:4002/api/repositories/valid_user
      {"status":200,"result":[{"user":"fabianopaes","url":"https://github.com/akullpp/awesome-java","updated_at":"2018-03-26T03:08:57.142882","tags":["elixirr","elixir"],"name":"awesome-java","language":null,"inserted_at":"2018-03-26T03:08:19.653554","id":283,"description":"A curated list of awesome frameworks, libraries and software for the Java programming language."},...]}
  """
  def repositories_by_user(conn, %{"user" => username}) do
    repos = Repository.get_by_user(username)

    json(conn, %{status: 200, result: sanitize_map(repos)})
  end

  @doc """
  Get a repository by user and tag

    params:
      - user: Github Username
      - tag: tag to search

  ## Examples
      $ curl -X GET http://localhost:4002/api/repositories/mbenatti/elixir
      {"status":200,"result":[{"user":"mbenatti","url":"https://github.com/2trde/excrawl","updated_at":"2018-03-26T03:01:55.738564","tags":["tag2","elixir"],"name":"excrawl","language":"Elixir","inserted_at":"2018-03-26T03:01:13.962738","id":168,"description":"Elixir web crawler"}]}
  """
  def repositories_by_tag(conn, %{"user" => username, "tag" => tag}) do
    repos = Repository.get_by_tag(username, tag)

    json(conn, %{status: 200, result: sanitize_map(repos)})
  end

  @doc """
  Get a repository by user and tag

    params:
      - user: Github Username
      - url: repository url
      - tag: tag to search

  ## Examples
      $ curl -X GET http://localhost:4002/api/repositories/mbenatti/elixir
      {"status":200,"result":[{"user":"mbenatti","url":"https://github.com/2trde/excrawl","updated_at":"2018-03-26T03:01:55.738564","tags":["tag2","elixir"],"name":"excrawl","language":"Elixir","inserted_at":"2018-03-26T03:01:13.962738","id":168,"description":"Elixir web crawler"}]}
  """
  def add_tag(conn, %{"user" => username, "url" => url, "tag" => tag}) do
    message =
      case Repository.add_tag_by_url(username, url, tag) do
        "repository not found" -> "repository not found"
        {:ok, _repo} -> "Tag added"
      end

    json(conn, %{status: 200, message: message})
  end

  @doc """
  Get a repository by user and tag

    params:
      - user: Github Username
      - url: repository url
      - tag: tag to search

  ## Examples
      $ curl -H "Content-Type: application/json" -X POST -d '{"user":"mbenatti","url":"https://github.com/h4cc/awesome-elixir","tag":"elixir-lang"}' http://localhost:4002/api/repositories/remove_tag
      {"status":200,"message":"Tag removed"}

      $ curl -H "Content-Type: application/json" -X POST -d '{"user":"mbenattii","url":"https://github.com/h4cc/awesome-elixirr","tag":"elixir-lang"}' http://localhost:4002/api/repositories/remove_tag
      {"status":200,"message":"repository not found"}
  """
  def remove_tag(conn, %{"user" => username, "url" => url, "tag" => tag}) do
    message =
      case Repository.remove_tag(username, url, tag) do
        "repository not found" -> "repository not found"
        {:ok, _repo} -> "Tag removed"
      end

    json(conn, %{status: 200, message: message})
  end

  defp sanitize_map(map) when is_map(map) do
    Map.drop(map, [:__meta__, :__struct__, :user_username, :repositories])
  end

  defp sanitize_map(list) when is_list(list) do
    Enum.map(list, &sanitize_map(&1))
  end
end
