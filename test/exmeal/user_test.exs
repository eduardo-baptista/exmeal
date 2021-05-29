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
      assert %Changeset{
               errors: [
                 cpf: {
                   "has already been taken",
                   [constraint: :unique, constraint_name: "users_cpf_index"]
                 }
               ],
               valid?: false
             } = result
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
      assert %Changeset{
               errors: [
                 email: {
                   "has already been taken",
                   [constraint: :unique, constraint_name: "users_email_index"]
                 }
               ],
               valid?: false
             } = result
    end

    test "When email is not valid, should return an invalid changeset" do
      # Arrange
      params = params_for(:user, %{email: "invalid"})

      # Act
      result = User.changeset(params)

      # Assert
      assert %Changeset{
               errors: [email: {"has invalid format", [validation: :format]}],
               valid?: false
             } = result
    end

    test "When has missing params, should return an invalid changeset" do
      # Arrange
      params = %{}

      # Act
      result = User.changeset(params)

      # Assert
      assert %Changeset{
               errors: [
                 name: {"can't be blank", [validation: :required]},
                 cpf: {"can't be blank", [validation: :required]},
                 email: {"can't be blank", [validation: :required]}
               ],
               valid?: false
             } = result
    end

    test "When updates user, should return a valid changeset" do
      # Arrange
      user = insert(:user)
      params = %{cpf: "10020030040", email: "new_email@email.com"}

      # Act
      result = User.changeset(user, params)

      # Assert
      assert %Changeset{
               changes: %{cpf: "10020030040", email: "new_email@email.com"},
               valid?: true
             } = result
    end
  end
end
