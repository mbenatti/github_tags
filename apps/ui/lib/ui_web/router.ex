defmodule GithubTags.UIWeb.Router do
  use GithubTags.UIWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GithubTags.UIWeb do
    pipe_through :browser # Use the default browser stack

    get "/", UserController, :index
    post "/repos", UserController, :repos

    get "/repositories", RepositoryController, :index
    post "/add_tag", RepositoryController, :add_tag
    post "/remove_tag", RepositoryController, :remove_tag
  end

  # Other scopes may use custom stacks.
  # scope "/api", GithubTags.UIWeb do
  #   pipe_through :api
  # end
end
