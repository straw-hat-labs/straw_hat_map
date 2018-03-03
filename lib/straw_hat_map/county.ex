defmodule StrawHat.Map.County do
  @moduledoc """
  Defines functionality for county management.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.{CountyQuery, CityQuery}
  alias StrawHat.Map.Schema.{County, City}

  @doc """
  Get the list of counties.
  """
  @spec get_counties(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_counties(pagination \\ []), do: Repo.paginate(County, pagination)

  @doc """
  Create a county.
  """
  @spec create_county(County.county_attrs()) ::
          {:ok, County.t()} | {:error, Ecto.Changeset.t()}
  def create_county(county_attrs) do
    %County{}
    |> County.changeset(county_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a county.
  """
  @spec update_county(County.t(), County.county_attrs()) ::
          {:ok, County.t()} | {:error, Ecto.Changeset.t()}
  def update_county(%County{} = county, county_attrs) do
    county
    |> County.changeset(county_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a county.
  """
  @spec destroy_county(County.t()) :: {:ok, County.t()} | {:error, Ecto.Changeset.t()}
  def destroy_county(%County{} = county), do: Repo.delete(county)

  @doc """
  Get a county by `id`.
  """
  @spec find_county(String.t()) :: {:ok, County.t()} | {:error, Error.t()}
  def find_county(county_id) do
    case get_county(county_id) do
      nil ->
        error = Error.new("straw_hat_map.county.not_found", metadata: [county_id: county_id])
        {:error, error}

      county ->
        {:ok, county}
    end
  end

  @doc """
  Get a county by `id`.
  """
  @spec get_county(String.t()) :: County.t() | nil | no_return
  def get_county(county_id), do: Repo.get(County, county_id)

  @doc """
  Get list of counties.
  """
  @spec get_counties_by_ids([integer()]) :: [County.t()] | no_return()
  def get_counties_by_ids(county_ids) do
    County
    |> CountyQuery.by_ids(county_ids)
    |> Repo.all()
  end

  @doc """
  Get list of cities.
  """
  @spec get_cities([integer()]) :: [State.t()] | no_return()
  def get_cities(county_ids) when is_list(county_ids) do
    City
    |> CityQuery.by_counties(county_ids)
    |> Repo.all()
  end
end
