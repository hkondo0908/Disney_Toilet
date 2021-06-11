defmodule Toilet.Repo.Migrations.CreateToilets do
  use Ecto.Migration

  def change do
    create table(:toilets) do
      add :name, :string
      add :latitude, :float
      add :longitude, :float
    end
  end
end
