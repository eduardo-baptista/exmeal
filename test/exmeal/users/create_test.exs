defmodule Exmeal.Users.CreateTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.{Error, User}
  alias Exmeal.Users.Create

  describe "call/1" do
    test "When all params are valid, should return created user" do
      # Arrange
      params = params_for(:user)

      # Act
      result = Create.call(params)

      # Assert
      %{cpf: cpf, email: email, name: name} = params

      assert {:ok,
              %User{
                id: _id,
                cpf: cpf,
                email: email,
                name: name
              }} = result
    end

    test "When already has a user with same cpf, should return validation error" do
      # Arrange
      insert(:user)
      params = params_for(:user, %{email: "email@mail.com"})

      # Act
      result = Create.call(params)

      # Assert
      assert {:error, %Error{status: :bad_request, result: errors}} = result
      assert %{cpf: ["has already been taken"]} == errors_on(errors)
    end

    test "When already has a user with same email, should return validation error" do
      # Arrange
      insert(:user)
      params = params_for(:user, %{cpf: "10020030040"})

      # Act
      result = Create.call(params)

      # Assert
      assert {:error, %Error{status: :bad_request, result: errors}} = result
      assert %{email: ["has already been taken"]} == errors_on(errors)
    end

    test "When email is not valid, should return an invalid changeset" do
      # Arrange
      params = params_for(:user, %{email: "invalid"})

      # Act
      result = Create.call(params)

      # Assert
      assert {:error, %Error{status: :bad_request, result: errors}} = result
      assert %{email: ["has invalid format"]} == errors_on(errors)
    end

    test "When has missing params, should return an invalid changeset" do
      # Arrange
      params = %{}

      # Act
      result = Create.call(params)

      # Assert
      assert {:error, %Error{status: :bad_request, result: errors}} = result

      assert %{
               email: ["can't be blank"],
               cpf: ["can't be blank"],
               name: ["can't be blank"]
             } == errors_on(errors)
    end
  end
end
