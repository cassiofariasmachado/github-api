defmodule Github.Repositories.GetReposTest do
  use ExUnit.Case, async: true

  import Mox
  import Github.Factory

  alias Github.ClientMock
  alias Github.Repositories.GetRepos

  describe "call/1" do
    test "returns repos" do
      username = "cassiofariasmachado"

      repos = build_list(3, :repo)

      expect(ClientMock, :get_repos, fn _username ->
        {:ok, repos}
      end)

      response = GetRepos.call(username)

      expected_response = {:ok, repos}

      assert expected_response == response
    end
  end
end
