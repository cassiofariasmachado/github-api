defmodule Github.Factory do
  use ExMachina.Ecto, repo: Github.Repo

  alias Github.Repository

  def repo_factory do
    %Repository{
      description:
        "Repository for my Exlivery project of the Elixir's path from Rocketseat Ignite.",
      html_url: "https://github.com/cassiofariasmachado/exlivery",
      id: 349_266_841,
      name: "exlivery",
      stargazers_count: 0
    }
  end
end
