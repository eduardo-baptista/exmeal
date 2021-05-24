defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase

  describe "Create Meal" do
    test "when all params are valid, returns the meal" do
      params = %{
        calories: 20,
        date: "2021-05-24T22:00:00Z",
        description: "Banana"
      }

      response = Exmeal.create_meal(params)

      assert {:ok,
              %Exmeal.Meal{
                calories: 20,
                date: ~U[2021-05-24 22:00:00Z],
                description: "Banana",
                id: _id
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        calories: 20,
        date: ~D[2001-05-02]
      }

      response = Exmeal.create_meal(params)

      assert {:error, %Exmeal.Error{}} = response
    end
  end
end
