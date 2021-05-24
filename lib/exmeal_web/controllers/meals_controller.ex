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
end
