defmodule Github.ClientTest do
  use ExUnit.Case, async: true

  alias Github.{Client, Error}
  alias Plug.Conn

  describe "get_repos/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when user exists and has repositories, returns the repositories", %{bypass: bypass} do
      username = "cassiofariasmachado"

      body = File.read!("test/resources/repositories/cassiofariasmachado.json")

      url = build_localhost_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repos(url, username)

      expected_response = {
        :ok,
        [
          %Github.Repository{
            description:
              "Repository for my Exlivery project of the Elixir's path from Rocketseat Ignite.",
            html_url: "https://github.com/cassiofariasmachado/exlivery",
            id: 349_266_841,
            name: "exlivery",
            stargazers_count: 0
          },
          %Github.Repository{
            description:
              "Repository for the fourth challenge of the Elixir's path from Rocketseat Ignite.",
            html_url: "https://github.com/cassiofariasmachado/flightex",
            id: 349_759_949,
            name: "flightex",
            stargazers_count: 0
          }
        ]
      }

      assert expected_response == response
    end

    test "when user not exists, returns an error", %{bypass: bypass} do
      username = "cassiofariasmachado"

      url = build_localhost_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, "")
      end)

      response = Client.get_repos(url, username)

      expected_response = {
        :error,
        %Error{
          message: "User not found",
          status: :not_found
        }
      }

      assert expected_response == response
    end

    test "when returns bad request getting the repositories, returns an error", %{bypass: bypass} do
      username = "cassiofariasmachado"

      url = build_localhost_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(400, "")
      end)

      response = Client.get_repos(url, username)

      expected_response = {
        :error,
        %Error{
          message: "Bad request getting repos",
          status: :bad_request
        }
      }

      assert expected_response == response
    end
  end

  defp build_localhost_url(port), do: "http://localhost:#{port}/"
end
