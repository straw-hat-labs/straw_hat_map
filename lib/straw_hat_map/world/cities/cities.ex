defmodule StrawHat.Map.Cities do
  @moduledoc """
  Cities management use cases.
  """

  import Ecto.Query
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.City

  @spec get_cities(Ecto.Repo.t(), Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_cities(repo, pagination \\ []) do
    repo.paginate(City, pagination)
  end

  @spec create_city(Ecto.Repo.t(), City.city_attrs()) :: Response.t(City.t(), Ecto.Changeset.t())
  def create_city(repo, city_attrs) do
    %City{}
    |> City.changeset(city_attrs)
    |> repo.insert()
    |> Response.from_value()
  end

  @spec update_city(Ecto.Repo.t(), City.t(), City.city_attrs()) ::
          Response.t(City.t(), Ecto.Changeset.t())
  def update_city(repo, %City{} = city, city_attrs) do
    city
    |> City.changeset(city_attrs)
    |> repo.update()
    |> Response.from_value()
  end

  @spec destroy_city(Ecto.Repo.t(), City.t()) :: Response.t(City.t(), Ecto.Changeset.t())
  def destroy_city(repo, %City{} = city) do
    city
    |> repo.delete()
    |> Response.from_value()
  end

  @spec find_city(Ecto.Repo.t(), String.t()) :: Response.t(City.t(), Error.t())
  def find_city(repo, city_id) do
    repo
    |> get_city(city_id)
    |> Response.from_value(
      Error.new("straw_hat_map.city.not_found", metadata: [city_id: city_id])
    )
  end

  @spec get_city(Ecto.Repo.t(), String.t()) :: City.t() | nil | no_return
  def get_city(repo, city_id) do
    repo.get(City, city_id)
  end

  @spec get_cities_by_ids(Ecto.Repo.t(), [integer()]) :: [City.t()] | no_return()
  def get_cities_by_ids(repo, city_ids) do
    City
    |> select([city], city)
    |> where([city], city.id in ^city_ids)
    |> repo.all()
  end

  @spec get_postal_code_rule(Ecto.Repo.t(), Integer.t()) :: Regex.t() | nil
  def get_postal_code_rule(repo, city_id) do
    repo
    |> get_city(city_id)
    |> repo.preload(state: :country)
    |> Map.get(:state)
    |> Map.get(:country)
    |> Map.get(:postal_code_rule)
  end
end
