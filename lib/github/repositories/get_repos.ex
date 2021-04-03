defmodule Github.Repositories.GetRepos do
  import Github.Client, only: [get_client: 0]

  def call(username), do: get_client().get_repos(username)
end
