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
    Enum.map(
      [
        CreateCountriesTable,
        CreateStatesTable,
        CreateCountiesTable,
        CreateCitiesTable,
        CreateAddressesTable,
        CreateLocationsTable,
        AddPostgisPlugin,
        AddGeoLocationToLocationsTable,
        AddPostalCodeRuleToCountries
      ],
      &apply(&1, :change, [])
    )
  end
end
