defmodule Github do
  @moduledoc """
  Github keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Github.Repositories.Get, as: GetRepos

  alias Github.Users.Create, as: CreateUser
  alias Github.Users.Get, as: GetUser

  defdelegate get_repos_from_user(username), to: GetRepos, as: :from_user

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
end
