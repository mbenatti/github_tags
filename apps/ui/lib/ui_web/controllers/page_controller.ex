defmodule GithubTags.UIWeb.PageController do
  use GithubTags.UIWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
