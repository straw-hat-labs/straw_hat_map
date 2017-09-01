defmodule StrawHat.Map.City do
  alias StrawHat.Map.Query.City, as: CityQuery
  alias StrawHat.Error
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.City

  def list_cities(paginate), do: Repo.paginate(City, paginate)

  def create_city(params) do
    %City{}
    |> City.changeset(params)
    |> Repo.insert()
  end

  def update_city(%City{} = city, params) do
    city
    |> City.changeset(params)
    |> Repo.update()
  end

  def destroy_city(%City{} = city), do: Repo.delete(city)

  def find_city(id) do
    case get_city(id) do
      nil -> {:error, Error.new("map.city.not_found", metadata: [id: id])}
      city -> {:ok, city}
    end
  end

  def get_city(id), do: Repo.get(City, id)

  def city_by_ids(city_ids) do
    City
    |> CityQuery.by_ids(city_ids)
    |> Repo.all()
  end

  def cities_by_state(id) do
    City
    |> CityQuery.by_state(id)
    |> Repo.all()
  end

  def cities_by_states(ids) do
    City
    |> CityQuery.by_states(ids)
    |> Repo.all()
  end

  def cities_by_counties(ids) do
    City
    |> CityQuery.by_countries(ids)
    |> Repo.all()
  end
end
