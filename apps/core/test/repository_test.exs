defmodule GithubTags.RepositoryTest do
  use ExUnit.Case

  alias GithubTags.Model.User
  alias GithubTags.Model.Repository

  # This user is from a friend of mine, should be fine to test with it
  @user "fabianopaes"
  @repo "https://github.com/google/styleguide"
  @tag_string "services"

  setup_all do
    user = User.get_or_create_user(@user)
    Repository.populate_or_update_repositories(user.username)

    {:ok, user: user}
  end

  describe "Repositories_CRUD" do
    test "update repos", %{user: user} do
      return = Repository.populate_or_update_repositories(user.username)

      assert return == :ok
    end

    test "get by url", %{user: user} do
      repo = Repository.get_by_url(user.username, @repo)

      assert repo.url == @repo
    end

    test "get invalid repo", %{user: user} do
      repo = Repository.get_by_url(user.username, "www.google.com")

      refute !is_nil(repo)
    end

    test "get by user", %{user: user} do
      repos = Repository.get_by_user(user.username)

      assert is_list(repos) == true
      assert Enum.empty?(repos) == false
    end

    test "get all repos" do
      repos = Repository.get_all()

      assert is_list(repos) == true
      assert Enum.empty?(repos) == false
    end
  end

  describe "Tags manipulation" do
    test "add tag", %{user: user} do
      {status, _repo} = Repository.add_tag_by_url(user.username, @repo, @tag_string)

      assert status == :ok
    end

    test "remove tag", %{user: user} do
      {status, _repo} = Repository.remove_tag(user.username, @repo, @tag_string)

      assert status == :ok
    end

    test "refute duplicate tag insert", %{user: user} do
      Repository.add_tag_by_url(user.username, @repo, @tag_string)
      {_status, repo} = Repository.add_tag_by_url(user.username, @repo, @tag_string)

      assert length(repo.tags) == length(Enum.uniq(repo.tags))
    end

    test "get tags", %{user: user} do
      Repository.add_tag_by_url(user.username, @repo, @tag_string)
      repo = Repository.get_by_url(user.username, @repo)

      assert is_list(repo.tags)
      assert @tag_string in repo.tags
    end
  end
end
