defmodule GithubWeb.RepositoriesController do
  use GithubWeb, :controller

  alias GithubWeb.FallbackController

  action_fallback(FallbackController)

  def index(conn, %{"username" => username}) do
    with {:ok, repos} <- Github.get_repos_from_user(username) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos)
    end
  end
end
