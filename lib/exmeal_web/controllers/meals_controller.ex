defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller
  alias ExmealWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, meal} <- Exmeal.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

  def update(conn, %{"id" => _id} = params) do
    with {:ok, meal} <- Exmeal.update_meal(params) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, meal} <- Exmeal.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end
end
