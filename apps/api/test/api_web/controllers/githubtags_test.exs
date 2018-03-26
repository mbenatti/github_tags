defmodule GithubTags.APIWeb.GithubtagsControllerTest do
  use GithubTags.APIWeb.ConnCase

  @user "fabianopaes"
  @repo "https://github.com/google/styleguide"
  @tag_string "elixir"

  setup do
    conn =
      build_conn()
      |> put_req_header("content-type", "application/json")
      |> put_req_header("accept", "application/json")

    {:ok,
      conn: conn
    }
  end
  describe "User creation" do
    test "create user and populate users", %{conn: conn} do
      conn = put(conn, "/api/create_user/#{@user}")

      %{"status" => status, "message" => message} = json_response(conn, 200)

      assert conn.status == 200
      assert status == 200
      assert message == "User created"
    end
  end

  describe "Repositories and Tags Manipulation" do
    test "get repositories", %{conn: conn} do
      conn = get(conn, "/api/repositories/#{@user}")

      %{"status" => status, "result" => result} = json_response(conn, 200)

      assert conn.status == 200
      assert status == 200
      assert is_list(result)
    end

    test "get repositories by tag", %{conn: conn} do
      conn = get(conn, "/api/repositories/#{@user}/#{@tag_string}")

      %{"status" => status, "result" => result} = json_response(conn, 200)

      assert conn.status == 200
      assert status == 200
      assert is_list(result)
    end

    test "add tag", %{conn: conn} do
      conn =
        post(conn, "/api/repositories/add_tag",
          %{"user" => @user, "tag" => @tag_string, "url" => @repo}
        )

      %{"status" => status, "message" => message} = json_response(conn, 200)

      assert conn.status == 200
      assert status == 200
      assert is_bitstring(message)
    end

    test "remove tag", %{conn: conn} do
      conn =
        post(conn, "/api/repositories/remove_tag",
          %{"user" => @user, "tag" => @tag_string, "url" => @repo}
        )

      %{"status" => status, "message" => message} = json_response(conn, 200)

      assert conn.status == 200
      assert status == 200
      assert is_bitstring(message)
    end
  end
end
