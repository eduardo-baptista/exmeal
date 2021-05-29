defmodule Exmeal.Users.DeleteTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Delete

  describe "call/1" do
    test "When user exists, should delete the user" do
      # Arrange
      %{id: user_id} = insert(:user)

      # Act
      result = Delete.call(user_id)

      # Assert
      assert {:ok, %User{id: ^user_id}} = result
    end

    test "When user not exist, should return an error" do
      # Arrange
      user_id = "fd32986b-f164-4e65-924b-c1b650e01209"

      # Act
      result = Delete.call(user_id)

      # Assert
      expected_response = {
        :error,
        %Exmeal.Error{result: "User not found", status: :not_found}
      }

      assert result == expected_response
    end
  end
end
