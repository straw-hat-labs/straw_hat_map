defmodule StrawHat.Map.TestSupport.Repo.Migrations.RunAllMigrations do
  use Ecto.Migration

  def change do
    Enum.map(
      [
        StrawHat.Map.Migrations.CreateCountriesTable,
        StrawHat.Map.Migrations.CreateStatesTable,
        StrawHat.Map.Migrations.CreateCountiesTable,
        StrawHat.Map.Migrations.CreateCitiesTable,
        StrawHat.Map.Migrations.CreateAddressesTable,
        StrawHat.Map.Migrations.CreateLocationsTable,
        StrawHat.Map.Migrations.AddPostgisPlugin,
        StrawHat.Map.Migrations.AddGeoLocationToLocationsTable,
        StrawHat.Map.Migrations.AddPostalCodeRuleToCountries
      ],
      &apply(&1, :change, [])
    )
  end
end
