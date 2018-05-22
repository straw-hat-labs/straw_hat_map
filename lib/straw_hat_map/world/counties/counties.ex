defmodule StrawHat.Map.Counties do
  @moduledoc """
  Defines functionality for counties management.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.{County, City}

  @doc """
  Returns the list of counties.
  """
  @since "1.0.0"
  @spec get_counties(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_counties(pagination \\ []), do: Repo.paginate(County, pagination)

  @doc """
  Creates a county.
  """
  @since "1.0.0"
  @spec create_county(County.county_attrs()) :: {:ok, County.t()} | {:error, Ecto.Changeset.t()}
  def create_county(county_attrs) do
    %County{}
    |> County.changeset(county_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a county.
  """
  @since "1.0.0"
  @spec update_county(County.t(), County.county_attrs()) ::
          {:ok, County.t()} | {:error, Ecto.Changeset.t()}
  def update_county(%County{} = county, county_attrs) do
    county
    |> County.changeset(county_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys a county.
  """
  @since "1.0.0"
  @spec destroy_county(County.t()) :: {:ok, County.t()} | {:error, Ecto.Changeset.t()}
  def destroy_county(%County{} = county), do: Repo.delete(county)

  @doc """
  Gets a county by `id`.
  """
  @since "1.0.0"
  @spec find_county(String.t()) :: {:ok, County.t()} | {:error, Error.t()}
  def find_county(county_id) do
    county_id
    |> get_county()
    |> Response.from_value(
      Error.new("straw_hat_map.county.not_found", metadata: [county_id: county_id])
    )
  end

  @doc """
  Gets a county by `id`.
  """
  @since "1.0.0"
  @spec get_county(String.t()) :: County.t() | nil | no_return
  def get_county(county_id), do: Repo.get(County, county_id)

  @doc """
  Returns a list of counties.
  """
  @since "1.0.0"
  @spec get_counties_by_ids([integer()]) :: [County.t()] | no_return()
  def get_counties_by_ids(county_ids) do
    query = from(c in County, where: c.id in ^county_ids)
    Repo.all(query)
  end

  @doc """
  Return the list of cities from counties.
  """
  @since "1.0.0"
  @spec get_cities([integer()]) :: [State.t()] | no_return()
  def get_cities(county_ids) when is_list(county_ids) do
    query = from(city in City, where: city.county_id in ^county_ids)
    Repo.all(query)
  end
end
