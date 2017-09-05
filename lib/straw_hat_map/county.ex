defmodule StrawHat.Map.County do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.{CountyQuery, CityQuery}
  alias StrawHat.Map.Schema.{County, City}

  def get_counties(pagination \\ []), do: Repo.paginate(County, pagination)

  def create_county(county_attrs) do
    %County{}
    |> County.changeset(county_attrs)
    |> Repo.insert()
  end

  def update_county(%County{} = county, county_attrs) do
    county
    |> County.changeset(county_attrs)
    |> Repo.update()
  end

  def destroy_county(%County{} = county), do: Repo.delete(county)

  def find_county(county_id) do
    case get_county(county_id) do
      nil ->
        error = Error.new("map.county.not_found", metadata: [county_id: county_id])
        {:error, error}
      county -> {:ok, county}
    end
  end

  def get_county(county_id), do: Repo.get(County, county_id)

  def get_counties_by_ids(county_ids) do
    County
    |> CountyQuery.by_ids(county_ids)
    |> Repo.all()
  end

  def get_cities_by_counties(county_ids) do
    City
    |> CityQuery.by_counties(county_ids)
    |> Repo.all()
  end
end
