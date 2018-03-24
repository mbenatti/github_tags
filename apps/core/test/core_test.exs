defmodule GithubTags.CoreTest do
  use ExUnit.Case
  doctest GithubTags.Core

  test "greets the world" do
    assert GithubTags.Core.hello() == :world
  end
end
