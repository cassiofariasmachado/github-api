defmodule GithubWeb.Auth.Guardian do
  use Guardian, otp_app: :github

  alias Github.{Error, User}

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Github.get_user_by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Github.get_user_by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      _ -> {:error, Error.build(:unauthorized, "Invalid username or password")}
    end
  end

  def authenticate(_), do: {:error, Error.build(:unauthorized, "Invalid or missing params")}
end
