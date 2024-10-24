defmodule Elee.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string
      add :location, :string
      add :rating, :string
      add :cost, :string
      add :hours, :string

      timestamps(type: :utc_datetime)
    end
  end
end
