defmodule GithubTags.UIWeb.UserControllerTest do
  use GithubTags.UIWeb.ConnCase

  @user "fabianopaes"

  test "GET index /", %{conn: conn} do
    conn = get(conn, "/")

    assert conn.status == 200
    assert html_response(conn, 200) =~ "Githubstars"
  end

  test "submit repo", %{conn: conn} do
    conn =
      post(conn, "/repos", %{
        "user" => %{"username" => @user}
      })

    assert redirected_to(conn) == "/repositories?username=fabianopaes"
  end
end
