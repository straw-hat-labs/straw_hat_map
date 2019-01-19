defmodule StrawHat.Map.Migrations.AddGeoLocationToLocationsTable do
  @moduledoc """
  Add location column with Geo type to locations table.

  Created at: ~N[2018-03-10 20:37:20]
  """

  use Ecto.Migration

  def change do
    alter table(:locations) do
      add(:location, :geometry)
    end
  end
end
