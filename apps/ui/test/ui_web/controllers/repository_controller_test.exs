defmodule GithubTags.UIWeb.RepositoryControllerTest do
  use GithubTags.UIWeb.ConnCase

  @user "fabianopaes"
  @repo "https://github.com/akullpp/awesome-java"
  @tag_string "services"

  test "GET repositories page", %{conn: conn} do
    conn = get conn, "/repositories"

    assert conn.status == 200
    assert html_response(conn, 200) =~ "Repository"
  end

  test "filter by tag", %{conn: conn} do
    conn =
      get(conn, "/repositories", %{
        "user" =>
          %{"username" => @user,
            "tag" => @tag_string}
        }
      )

    assert conn.status == 200
    assert html_response(conn, 200) =~ "Repository"
  end

  test "add tag route", %{conn: conn} do
    conn =
      post(conn, "/add_tag", %{
        "params" =>
          %{"username" => @user,
            "tag" => @tag_string,
            "url" => @repo}
        }
      )

    assert conn.status == 302
    assert redirected_to(conn) =~ "/repositories"
  end

  test "remote tag route", %{conn: conn} do
    conn =
      post(conn, "/remove_tag", %{
        "params" =>
          %{"username" => @user,
            "tag" => @tag_string,
            "url" => @repo}
        }
      )

    assert conn.status == 302
    assert redirected_to(conn) =~ "/repositories"
  end
end
