defmodule Exmeal.Meals.Get do
  alias Exmeal.{Error, Meal, Repo}

  def by_id(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_not_found_error("Meal")}
      meal -> {:ok, meal}
    end
  end
end
