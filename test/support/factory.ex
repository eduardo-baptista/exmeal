defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.User

  def user_factory do
    %User{
      cpf: "11122233344",
      email: "marshall@email.com",
      name: "Marshall Eriksen"
    }
  end
end
