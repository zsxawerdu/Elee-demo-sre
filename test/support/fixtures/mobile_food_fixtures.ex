defmodule Elee.MobileFoodFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elee.MobileFood` context.
  """

  @doc """
  Generate a food.
  """
  def food_fixture(attrs \\ %{}) do
    {:ok, food} =
      attrs
      |> Enum.into(%{
        cost: "some cost",
        hours: "some hours",
        location: "some location",
        name: "some name",
        rating: "some rating"
      })
      |> Elee.MobileFood.create_food()

    food
  end
end
