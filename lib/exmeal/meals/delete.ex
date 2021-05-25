defmodule Exmeal.Meals.Delete do
  alias Exmeal.{Error, Meal, Repo}

  def call(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_not_found_error("Meal")}
      meal -> {:ok, Repo.delete!(meal)}
    end
  end
end
