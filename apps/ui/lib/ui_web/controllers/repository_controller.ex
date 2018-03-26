defmodule GithubTags.UIWeb.RepositoryController do
  use GithubTags.UIWeb, :controller

  alias GithubTags.Model.Repository

  def index(conn, %{"params" => %{"username" => username, "tag" => ""}}) do
    index(conn, %{"username" => username})
  end

  def index(conn, %{"params" => %{"username" => username, "tag" => tag}}) do
    render conn, "index.html",
      repositories:
        Repository.get_by_tag(username, tag) |> Enum.sort_by(&(&1.url)),
      user: username
  end

  def index(conn, %{"username" => username}) do
    render conn, "index.html",
      repositories:
        Repository.get_by_user(username) |> Enum.sort_by(&(&1.url)),
      user: username
  end

  def index(conn, _params) do
    index(conn, %{"username" => ""})
  end

  def add_tag(conn, %{"params" => %{"username" => username, "tag" => tag, "url" => url}}) do
    Repository.add_tag_by_url(username, url, tag)

    redirect(conn, to: "/repositories?username=#{username}")
  end

  def remove_tag(conn, %{"params" => %{"username" => username, "tag" => tag, "url" => url}}) do
    Repository.remove_tag(username, url, tag)

    redirect(conn, to: "/repositories?username=#{username}")
  end
end
