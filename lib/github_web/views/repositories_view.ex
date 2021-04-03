defmodule GithubWeb.RepositoriesView do
  use GithubWeb, :view

  alias Github.Repository

  def render("repos.json", %{repos: [%Repository{} | _] = repos}) do
    %{"repos" => repos}
  end
end
