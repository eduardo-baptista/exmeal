defmodule Exmeal.UserTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Ecto.Changeset
  alias Exmeal.User

  describe "changeset/2" do
    test "When all params are valid, should return a valid changeset" do
      # Arrange
      params = params_for(:user)

      # Act
      result = User.changeset(params)

      # Assert
      %{cpf: cpf, email: email, name: name} = params

      assert %Changeset{
               changes: %{
                 cpf: ^cpf,
                 email: ^email,
                 name: ^name
               },
               valid?: true
             } = result
    end

    test "When already has a user with same cpf, should return an invalid changeset" do
      # Arrange
      insert(:user)
      params = params_for(:user, %{email: "email@mail.com"})

      # Act
      {:error, result} =
        params
        |> User.changeset()
        |> Repo.insert()

      # Assert

      assert %{cpf: ["has already been taken"]} == errors_on(result)
    end

    test "When already has a user with same email, should return an invalid changeset" do
      # Arrange
      insert(:user)
      params = params_for(:user, %{cpf: "10020030040"})

      # Act
      {:error, result} =
        params
        |> User.changeset()
        |> Repo.insert()

      # Assert
      assert %{email: ["has already been taken"]} == errors_on(result)
    end

    test "When email is not valid, should return an invalid changeset" do
      # Arrange
      params = params_for(:user, %{email: "invalid"})

      # Act
      result = User.changeset(params)

      # Assert
      assert %{email: ["has invalid format"]} == errors_on(result)
    end

    test "When has missing params, should return an invalid changeset" do
      # Arrange
      params = %{}

      # Act
      result = User.changeset(params)

      # Assert
      assert %{
               email: ["can't be blank"],
               cpf: ["can't be blank"],
               name: ["can't be blank"]
             } == errors_on(result)
    end

    test "When updates user, should return a valid changeset" do
      # Arrange
      user = insert(:user)
      params = %{cpf: "10020030040", email: "new_email@email.com"}

      # Act
      result = User.changeset(user, params)

      # Assert
      assert %Changeset{
               changes: ^params,
               valid?: true
             } = result
    end
  end
end
