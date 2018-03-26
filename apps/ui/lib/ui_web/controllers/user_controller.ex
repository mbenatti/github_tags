defmodule GithubTags.UIWeb.UserController do
  use GithubTags.UIWeb, :controller

  alias GithubTags.Model.User
  alias GithubTags.Model.Repository

  def index(conn, _params) do
    render conn, "index.html",
      users: User.get_users()
  end

  def repos(conn, %{"user" => %{"username" => username}}) do
    User.get_or_create_user(username)
    Repository.populate_or_update_repositories(username)

    redirect(conn, to: "/repositories?username=#{username}")
  end
end
