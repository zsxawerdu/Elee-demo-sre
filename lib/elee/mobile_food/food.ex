defmodule Elee.MobileFood.Food do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods" do
    field :name, :string
    field :location, :string
    field :rating, :string
    field :cost, :string
    field :hours, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :location, :rating, :cost, :hours])
    |> validate_required([:name, :location, :rating, :cost, :hours])
  end
end
