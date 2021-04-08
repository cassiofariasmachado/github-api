defmodule GithubWeb.RepositoriesControllerTest do
  use GithubWeb.ConnCase, async: true

  import Github.{Factory, Support}
  import Mox

  alias Github.{ClientMock, Error}

  describe "index/2" do
    setup %{conn: conn} do
      user = insert(:user)

      conn = puth_auth_header(conn, user)

      {:ok, conn: conn}
    end

    test "when user exits and has repositories, returns the repositories", %{conn: conn} do
      username = "cassiofariasmachado"

      repos = build_list(2, :repo)

      expect(ClientMock, :get_repos, fn _username ->
        {:ok, repos}
      end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :index, username))
        |> json_response(:ok)

      expected_response = %{
        "repos" => [
          %{
            "description" =>
              "Repository for my Exlivery project of the Elixir's path from Rocketseat Ignite.",
            "html_url" => "https://github.com/cassiofariasmachado/exlivery",
            "id" => 349_266_841,
            "name" => "exlivery",
            "stargazers_count" => 0
          },
          %{
            "description" =>
              "Repository for my Exlivery project of the Elixir's path from Rocketseat Ignite.",
            "html_url" => "https://github.com/cassiofariasmachado/exlivery",
            "id" => 349_266_841,
            "name" => "exlivery",
            "stargazers_count" => 0
          }
        ]
      }

      assert expected_response == response
    end

    test "when user not exits, returns an error", %{conn: conn} do
      username = "cassiofariasmachado"

      expect(ClientMock, :get_repos, fn _username ->
        {:error, Error.build_not_found("User not found")}
      end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :index, username))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert expected_response == response
    end
  end
end
