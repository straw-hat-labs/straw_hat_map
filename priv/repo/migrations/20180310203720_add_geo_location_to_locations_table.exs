defmodule StrawHat.Map.Repo.Migrations.AddGeoLocationToLocationsTable do
  use Ecto.Migration

  def change do
    alter table(:locations) do
      add :location, :geometry
    end
  end
end
