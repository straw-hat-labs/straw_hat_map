defmodule StrawHat.Map.City do
  @moduledoc """
  Defines functionality for cities management.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.CityQuery
  alias StrawHat.Map.Schema.City

  @doc """
  Get the list of cities.
  """
  @spec get_cities(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_cities(pagination \\ []), do: Repo.paginate(City, pagination)

  @doc """
  Create a city.
  """
  @spec create_city(City.city_attrs()) :: {:ok, City.t()} | {:error, Ecto.Changeset.t()}
  def create_city(city_attrs) do
    %City{}
    |> City.changeset(city_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a city.
  """
  @spec update_city(City.t(), City.city_attrs()) :: {:ok, City.t()} | {:error, Ecto.Changeset.t()}
  def update_city(%City{} = city, city_attrs) do
    city
    |> City.changeset(city_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a city.
  """
  @spec destroy_city(City.t()) :: {:ok, City.t()} | {:error, Ecto.Changeset.t()}
  def destroy_city(%City{} = city), do: Repo.delete(city)

  @doc """
  Get a city by `id`.
  """
  @spec find_city(String.t()) :: {:ok, City.t()} | {:error, Error.t()}
  def find_city(city_id) do
    case get_city(city_id) do
      nil ->
        error = Error.new("straw_hat_map.city.not_found", metadata: [city_id: city_id])
        {:error, error}

      city ->
        {:ok, city}
    end
  end

  @doc """
  Get a city by `id`.
  """
  @spec get_city(String.t()) :: City.t() | nil | no_return
  def get_city(city_id), do: Repo.get(City, city_id)

  @doc """
  Get list of cities.
  """
  @spec get_cities_by_ids([integer()]) :: [City.t()] | no_return()
  def get_cities_by_ids(city_ids) do
    City
    |> CityQuery.by_ids(city_ids)
    |> Repo.all()
  end
end
