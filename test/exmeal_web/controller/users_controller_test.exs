defmodule Exmeal.UsersControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.User

  describe "create/2" do
    test "when all params are valid, creates a user", %{conn: conn} do
      params = string_params_for(:user)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "cpf" => "11122233344",
                 "email" => "marshall@email.com",
                 "id" => _id,
                 "name" => "Marshall Eriksen"
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = string_params_for(:user, %{email: "invalid", cpf: "123"})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{"cpf" => ["should be 11 character(s)"], "email" => ["has invalid format"]}
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when id exist, delete the user", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert "" = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "5e694bc0-78fc-4600-bcd0-0733b7540a6e"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{
               "message" => "User not found"
             } = response
    end
  end

  describe "update/2" do
    test "when id exist, update the user", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, %{"name" => "Barney Stinson"}))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "cpf" => "11122233344",
                 "email" => "marshall@email.com",
                 "name" => "Barney Stinson",
                 "id" => ^id
               }
             } = response
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = "5e694bc0-78fc-4600-bcd0-0733b7540a6e"

      response =
        conn
        |> put(Routes.users_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end
  end

  describe "get/2" do
    test "when id exist, return the user", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "cpf" => "11122233344",
                 "email" => "marshall@email.com",
                 "name" => "Marshall Eriksen",
                 "id" => ^id
               }
             } = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "5e694bc0-78fc-4600-bcd0-0733b7540a6e"

      response =
        conn
        |> get(Routes.users_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end
  end
end
