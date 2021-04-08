defmodule Github.Users.Get do
  alias Github.{Error, Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_not_found("User not found")}
      user -> {:ok, user}
    end
  end
end
