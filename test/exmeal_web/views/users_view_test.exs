defmodule ExmealWeb.UsersViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View
  import Exmeal.{Factory}

  alias ExmealWeb.UsersView

  test "render create.json" do
    user = insert(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: ^user
           } = response
  end

  test "render user.json" do
    user = insert(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{user: ^user} = response
  end
end
