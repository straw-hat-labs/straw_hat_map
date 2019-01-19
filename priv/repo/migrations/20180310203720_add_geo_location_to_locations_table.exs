defmodule StrawHat.Map.Repo.Migrations.AddGeoLocationToLocationsTable do
  use Ecto.Migration
  defdelegate change, to: StrawHat.Map.Migrations.AddGeoLocationToLocationsTable
end
