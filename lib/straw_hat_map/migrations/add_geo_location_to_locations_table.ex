defmodule StrawHat.Map.Migrations.AddGeoLocationToLocationsTable do
  @moduledoc false

  use Ecto.Migration

  @id ~N[2018-03-10 20:37:20]

  def change do
    alter table(:locations) do
      add(:location, :geometry)
    end
  end
end
