defmodule StrawHat.Map.Cities do
  @moduledoc """
  Defines functionality for cities management.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.City

  @doc """
  Gets the list of cities.
  """
  @since "1.0.0"
  @spec get_cities(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_cities(pagination \\ []) do
    Repo.paginate(City, pagination)
  end

  @doc """
  Creates a city.
  """
  @since "1.0.0"
  @spec create_city(City.city_attrs()) :: Response.t(City.t(), Ecto.Changeset.t())
  def create_city(city_attrs) do
    %City{}
    |> City.changeset(city_attrs)
    |> Repo.insert()
    |> Response.from_value()
  end

  @doc """
  Updates a city.
  """
  @since "1.0.0"
  @spec update_city(City.t(), City.city_attrs()) :: Response.t(City.t(), Ecto.Changeset.t())
  def update_city(%City{} = city, city_attrs) do
    city
    |> City.changeset(city_attrs)
    |> Repo.update()
    |> Response.from_value()
  end

  @doc """
  Destroys a city.
  """
  @since "1.0.0"
  @spec destroy_city(City.t()) :: Response.t(City.t(), Ecto.Changeset.t())
  def destroy_city(%City{} = city) do
    city
    |> Repo.delete()
    |> Response.from_value()
  end

  @doc """
  Gets a city by `id`.
  """
  @since "1.0.0"
  @spec find_city(String.t()) :: Response.t(City.t(), Error.t())
  def find_city(city_id) do
    city_id
    |> get_city()
    |> Response.from_value(
      Error.new("straw_hat_map.city.not_found", metadata: [city_id: city_id])
    )
  end

  @doc """
  Gets a city by `id`.
  """
  @since "1.0.0"
  @spec get_city(String.t()) :: City.t() | nil | no_return
  def get_city(city_id) do
    Repo.get(City, city_id)
  end

  @doc """
  Gets list of cities.
  """
  @since "1.0.0"
  @spec get_cities_by_ids([integer()]) :: [City.t()] | no_return()
  def get_cities_by_ids(city_ids) do
    query = from(city in City, where: city.id in ^city_ids)
    Repo.all(query)
  end

  @doc """
  Returns the postal code rule of the associated country.
  """
  @since "1.1.0"
  @spec get_postal_code_rule(Integer.t()) :: Regex.t() | nil
  def get_postal_code_rule(city_id) do
    city_id
    |> get_city()
    |> Repo.preload(state: :country)
    |> Map.get(:state)
    |> Map.get(:country)
    |> Map.get(:postal_code_rule)
  end
end
