defmodule StrawHat.Map.Country do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.CountryQuery
  alias StrawHat.Map.Schema.Country

  def get_countries(pagination \\ []), do: Repo.paginate(Country, pagination)

  def create_country(country_attrs) do
    %Country{}
    |> Country.changeset(country_attrs)
    |> Repo.insert()
  end

  def update_country(%Country{} = country, country_attrs) do
    country
    |> Country.changeset(country_attrs)
    |> Repo.update()
  end

  def destroy_country(%Country{} = country), do: Repo.delete(country)

  def find_country(country_id) do
    case get_country(country_id) do
      nil ->
        error = Error.new("map.country.not_found", metadata: [country_id: country_id])
        {:error, error}
      country -> {:ok, country}
    end
  end

  def get_country(country_id), do: Repo.get(Country, country_id)

  def get_countries_by_ids(country_ids) do
    Country
    |> CountryQuery.by_ids(country_ids)
    |> Repo.all()
  end
end
