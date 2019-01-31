defmodule StrawHat.Map.Counties do
  @moduledoc """
  Counties management use cases.
  """

  import Ecto.Query
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.{City, County}

  @spec get_counties(Ecto.Repo.t(), Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_counties(repo, pagination \\ []) do
    Scrivener.paginate(County, Scrivener.Config.new(repo, [], pagination))
  end

  @spec create_county(Ecto.Repo.t(), County.county_attrs()) ::
          Response.t(County.t(), Ecto.Changeset.t())
  def create_county(repo, county_attrs) do
    %County{}
    |> County.changeset(county_attrs)
    |> repo.insert()
    |> Response.from_value()
  end

  @spec update_county(Ecto.Repo.t(), County.t(), County.county_attrs()) ::
          Response.t(County.t(), Ecto.Changeset.t())
  def update_county(repo, %County{} = county, county_attrs) do
    county
    |> County.changeset(county_attrs)
    |> repo.update()
    |> Response.from_value()
  end

  @spec destroy_county(Ecto.Repo.t(), County.t()) :: Response.t(County.t(), Ecto.Changeset.t())
  def destroy_county(repo, %County{} = county) do
    county
    |> repo.delete()
    |> Response.from_value()
  end

  @spec find_county(Ecto.Repo.t(), String.t()) :: Response.t(County.t(), Error.t())
  def find_county(repo, county_id) do
    repo
    |> get_county(county_id)
    |> Response.from_value(
      Error.new("straw_hat_map.county.not_found", metadata: [county_id: county_id])
    )
  end

  @spec get_county(Ecto.Repo.t(), String.t()) :: County.t() | nil | no_return
  def get_county(repo, county_id) do
    repo.get(County, county_id)
  end

  @spec get_counties_by_ids(Ecto.Repo.t(), [integer()]) :: [County.t()] | no_return()
  def get_counties_by_ids(repo, county_ids) do
    County
    |> select([county], county)
    |> where([county], county.id in ^county_ids)
    |> repo.all()
  end

  @spec get_cities(Ecto.Repo.t(), [integer()]) :: [State.t()] | no_return()
  def get_cities(repo, county_ids) when is_list(county_ids) do
    City
    |> select([city], city)
    |> where([city], city.county_id in ^county_ids)
    |> repo.all()
  end
end
