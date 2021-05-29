defmodule Exmeal.Users.UpdateTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Update

  describe "call/1" do
    setup do
      %{id: user_id} = insert(:user)

      {:ok, id: user_id}
    end

    test "When updates existent user, should returns the user", %{id: user_id} do
      # Arrange
      params = %{"id" => user_id, "name" => "Barney Stinson"}

      # Act
      result = Update.call(params)

      # # Assert
      assert {:ok,
              %User{
                id: ^user_id,
                name: "Barney Stinson"
              }} = result
    end

    test "When user not exist, should return an error" do
      # Arrange
      user_id = "fd32986b-f164-4e65-924b-c1b650e01209"
      params = %{"id" => user_id, "name" => "Barney Stinson"}

      # Act
      result = Update.call(params)

      # Assert
      expected_response = {
        :error,
        %Error{result: "User not found", status: :not_found}
      }

      assert result == expected_response
    end

    test "When has invalid params, should return an error", %{id: user_id} do
      # Arrange
      params = %{"id" => user_id, "cpf" => "123"}

      # Act
      result = Update.call(params)

      # Assert
      assert {:error, %Error{result: errors, status: :bad_request}} = result

      expected_errors = %{cpf: ["should be 11 character(s)"]}
      assert errors_on(errors) == expected_errors
    end
  end
end
