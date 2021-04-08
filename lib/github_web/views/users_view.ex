defmodule GithubWeb.UsersView do
  use GithubWeb, :view

  alias Github.User

  def render("sign_in.json", %{token: token}), do: %{token: token}

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      user: user
    }
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
