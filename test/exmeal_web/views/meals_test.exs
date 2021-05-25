defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View

  alias Exmeal.Meal

  alias ExmealWeb.MealsView

  test "render create.json" do
    params = %{description: "Banana", date: "2021-05-24T22:00:00Z", calories: "20"}
    {_ok, meal} = Exmeal.create_meal(params)

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~U[2021-05-24 22:00:00Z],
               description: "Banana",
               id: _id
             },
             message: "Meal created!"
           } = response
  end

  test "render meal.json" do
    params = %{description: "Banana", date: "2021-05-24T22:00:00Z", calories: "20"}
    {_ok, meal} = Exmeal.create_meal(params)

    response = render(MealsView, "meal.json", meal: meal)

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~U[2021-05-24 22:00:00Z],
               description: "Banana",
               id: _id
             }
           } = response
  end
end
