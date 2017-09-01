defmodule StrawHat.Map.County do
  alias StrawHat.Map.Query.County, as: CountyQuery
  alias StrawHat.Error
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.County

  def list_counties(paginate), do: Repo.paginate(County, paginate)

  def create_county(params) do
    %County{}
    |> County.changeset(params)
    |> Repo.insert()
  end

  def update_county(%County{} = county, params) do
    county
    |> County.changeset(params)
    |> Repo.update()
  end

  def destroy_county(%County{} = county), do: Repo.delete(county)

  def find_county(id) do
    case get_county(id) do
      nil -> {:error, Error.new("map.county.not_found", metadata: [id: id])}
      county -> {:ok, county}
    end
  end

  def get_county(id), do: Repo.get(County, id)

  def county_by_ids(county_ids) do
    County
    |> CountyQuery.by_ids(county_ids)
    |> Repo.all()
  end

  def counties_by_states(ids) do
    County
    |> CountyQuery.by_states(ids)
    |> Repo.all()
  end
end
