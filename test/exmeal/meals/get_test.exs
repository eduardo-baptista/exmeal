defmodule Exmeal.Meals.GetTest do
  use Exmeal.DataCase

  describe "Get Meal" do
    test "when a valid id is given, returns the meal" do
      params = %{
        calories: 20,
        date: "2021-05-24T22:00:00Z",
        description: "Banana"
      }

      {_ok, meal} = Exmeal.create_meal(params)

      response = Exmeal.get_meal_by_id(meal.id)

      assert {:ok,
              %Exmeal.Meal{
                calories: 20,
                date: ~U[2021-05-24 22:00:00Z],
                description: "Banana",
                id: _id
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "a6ef9b39-d638-4835-9ad7-dbe48d1257eb"
      response = Exmeal.get_meal_by_id(id)

      assert {:error, %Exmeal.Error{result: "Meal not found", status: :not_found}} = response
    end
  end
end
