defmodule StrawHat.Map.Migrations.AddGeoLocationToLocationsTable do
  @moduledoc false

  use Ecto.Migration

  @id 20180310203720

  def change do
    alter table(:locations) do
      add(:location, :geometry)
    end
  end
end
