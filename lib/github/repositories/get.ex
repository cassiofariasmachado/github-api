defmodule Github.Repositories.Get do
  import Github.Client, only: [get_client: 0]

  def from_user(username), do: get_client().get_repos(username)
end
