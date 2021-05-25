defmodule Exmeal.MealTest do
  use Exmeal.DataCase

  alias Ecto.Changeset

  alias Exmeal.Meal

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = %{description: "Batata", date: "2021-05-24T22:00:00Z", calories: "20"}

      response = Meal.changeset(params)

      assert %Changeset{
               changes: %{description: "Batata", date: ~U[2021-05-24 22:00:00Z], calories: 20},
               valid?: true
             } = response
    end

    test "when there are invalid params, returns validation errors" do
      params = %{description: "Batata", date: "2021-05-24"}

      response = Meal.changeset(params)

      expected_response = %{calories: ["can't be blank"], date: ["is invalid"]}
      assert errors_on(response) == expected_response
    end
  end
end
