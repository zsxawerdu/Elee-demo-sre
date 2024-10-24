defmodule Elee.MobileFoodTest do
  use Elee.DataCase

  alias Elee.MobileFood

  describe "foods" do
    alias Elee.MobileFood.Food

    import Elee.MobileFoodFixtures

    @invalid_attrs %{name: nil, location: nil, rating: nil, cost: nil, hours: nil}

    test "list_foods/0 returns all foods" do
      food = food_fixture()
      assert MobileFood.list_foods() == [food]
    end

    test "get_food!/1 returns the food with given id" do
      food = food_fixture()
      assert MobileFood.get_food!(food.id) == food
    end

    test "create_food/1 with valid data creates a food" do
      valid_attrs = %{name: "some name", location: "some location", rating: "some rating", cost: "some cost", hours: "some hours"}

      assert {:ok, %Food{} = food} = MobileFood.create_food(valid_attrs)
      assert food.name == "some name"
      assert food.location == "some location"
      assert food.rating == "some rating"
      assert food.cost == "some cost"
      assert food.hours == "some hours"
    end

    test "create_food/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MobileFood.create_food(@invalid_attrs)
    end

    test "update_food/2 with valid data updates the food" do
      food = food_fixture()
      update_attrs = %{name: "some updated name", location: "some updated location", rating: "some updated rating", cost: "some updated cost", hours: "some updated hours"}

      assert {:ok, %Food{} = food} = MobileFood.update_food(food, update_attrs)
      assert food.name == "some updated name"
      assert food.location == "some updated location"
      assert food.rating == "some updated rating"
      assert food.cost == "some updated cost"
      assert food.hours == "some updated hours"
    end

    test "update_food/2 with invalid data returns error changeset" do
      food = food_fixture()
      assert {:error, %Ecto.Changeset{}} = MobileFood.update_food(food, @invalid_attrs)
      assert food == MobileFood.get_food!(food.id)
    end

    test "delete_food/1 deletes the food" do
      food = food_fixture()
      assert {:ok, %Food{}} = MobileFood.delete_food(food)
      assert_raise Ecto.NoResultsError, fn -> MobileFood.get_food!(food.id) end
    end

    test "change_food/1 returns a food changeset" do
      food = food_fixture()
      assert %Ecto.Changeset{} = MobileFood.change_food(food)
    end
  end
end
