defmodule StrawHat.Map.City do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.CityQuery
  alias StrawHat.Map.Schema.City

  def get_cities(pagination \\ []), do: Repo.paginate(City, pagination)

  def create_city(city_attrs) do
    %City{}
    |> City.changeset(city_attrs)
    |> Repo.insert()
  end

  def update_city(%City{} = city, city_attrs) do
    city
    |> City.changeset(city_attrs)
    |> Repo.update()
  end

  def destroy_city(%City{} = city), do: Repo.delete(city)

  def find_city(city_id) do
    case get_city(city_id) do
      nil ->
        error = Error.new("map.city.not_found", metadata: [city_id: city_id])
        {:error, error}

      city ->
        {:ok, city}
    end
  end

  def get_city(city_id), do: Repo.get(City, city_id)

  def get_cities_by_ids(city_ids) do
    City
    |> CityQuery.by_ids(city_ids)
    |> Repo.all()
  end
end
