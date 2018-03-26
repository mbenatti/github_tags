defmodule GithubTags.UserTest do
  use ExUnit.Case

  alias GithubTags.Model.User

  @user1 "mbenatti"
  @user2 "fabianopaes"
  @user3 "josevalim"

  setup_all do
    user_marcos = User.get_or_create_user(@user1)
    user_fabiano = User.get_or_create_user(@user2)

    {:ok, user1: user_marcos, user2: user_fabiano}
  end

  test "Validate create_user success", %{user1: user1, user2: user2} do
    assert user1.username == @user1
    assert user2.username == @user2
  end

  test "Retrive or create an User" do
    user_retrived = User.get_or_create_user(@user1)
    user_created = User.get_or_create_user(@user3)

    assert is_map(user_retrived) == true
    assert user_retrived.username == @user1

    assert is_map(user_created) == true
    assert user_created.username == @user3
  end

  test "Get specific User" do
    user = User.get_or_create_user(@user2)

    assert is_map(user) == true
    assert user.username == @user2
  end

  test "Get all Users" do
    users = User.get_users()
    first_user = List.first(users)

    assert is_list(users) == true
    assert length(users) > 0
    assert is_bitstring(first_user.username) == true
    assert first_user.username in [@user1, @user2, @user3]
  end
end
