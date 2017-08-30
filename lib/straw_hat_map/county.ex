defmodule StrawHat.Map.County do
  import Ecto.Query, only: [from: 2]

  alias StrawHat.Error
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.County

  def list_counties(params),
    do: Repo.paginate(County, params)

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
  def update_county(id, params) do
    with {:ok, county} <- find_county(id),
      do: update_county(county, params)
  end

  def destroy_county(%County{} = county),
    do: Repo.delete(county)
  def destroy_county(id) do
    with {:ok, county} <- find_county(id),
      do: destroy_county(county)
  end

  def find_county(id) do
    case get_county(id) do
      nil -> {:error, Error.new("map.county.not_found", metadata: [id: id])}
      county -> {:ok, county}
    end
  end

  def get_county(id),
    do: Repo.get(County, id)

  def county_by_ids(county_ids) do
    query =
      from county in County,
      where: county.id in ^county_ids
    Repo.all(query)
  end

  def counties_by_states(ids) do
    query =
      from county in County,
      where: county.state_id in ^ids
    Repo.all(query)
  end
end
