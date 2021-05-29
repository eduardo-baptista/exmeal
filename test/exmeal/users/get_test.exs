defmodule Exmeal.Users.GetTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Get

  describe "call/1" do
    test "When user exists, should returns the user" do
      # Arrange
      %{id: user_id} = user = insert(:user)

      # Act
      result = Get.call(user_id)

      # Assert
      expected_response = {:ok, user}
      assert result == expected_response
    end

    test "When user not exist, should return an error" do
      # Arrange
      user_id = "fd32986b-f164-4e65-924b-c1b650e01209"

      # Act
      result = Get.call(user_id)

      # Assert
      expected_response = {
        :error,
        %Error{result: "User not found", status: :not_found}
      }

      assert result == expected_response
    end
  end
end
