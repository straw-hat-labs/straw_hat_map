defmodule StrawHat.Map.Repo.Migrations.RunAllMigrations do
  use Ecto.Migration

  alias StrawHat.Map.Migrations.{
    CreateCountriesTable,
    CreateStatesTable,
    CreateCountiesTable,
    CreateCitiesTable,
    CreateAddressesTable,
    CreateLocationsTable,
    AddPostgisPlugin,
    AddGeoLocationToLocationsTable,
    AddPostalCodeRuleToCountries
  }

  def change do
    CreateCountriesTable.change()
    CreateStatesTable.change()
    CreateCountiesTable.change()
    CreateCitiesTable.change()
    CreateAddressesTable.change()
    CreateLocationsTable.change()
    AddPostgisPlugin.change()
    AddGeoLocationToLocationsTable.change()
    AddPostalCodeRuleToCountries.change()
  end
end
