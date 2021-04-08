defmodule Github.Factory do
  use ExMachina.Ecto, repo: Github.Repo

  alias Github.{Repository, User}

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

  def user_factory do
    %User{
      id: "a8691f63-3586-4136-b4b2-ba45ae53d4e4",
      password: "123456"
    }
  end
end
