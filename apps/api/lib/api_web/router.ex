defmodule GithubTags.APIWeb.Router do
  use GithubTags.APIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubTags.APIWeb do
    pipe_through :api

    put "/create_user/:user", GithubtagsController, :create_user

    get "/repositories/:user", GithubtagsController, :repositories_by_user
    get "/repositories/:user/:tag", GithubtagsController, :repositories_by_tag

    post "/repositories/add_tag", GithubtagsController, :add_tag
    post "/repositories/remove_tag", GithubtagsController, :remove_tag
  end
end
