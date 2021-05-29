defmodule Exmeal.Users.Delete do
  alias Exmeal.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_not_found_error("User")}
      user -> {:ok, Repo.delete!(user)}
    end
  end
end
