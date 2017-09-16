defmodule StrawHat.Map.Location do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.LocationQuery
  alias StrawHat.Map.Schema.Location

  def destroy_location(%Location{} = location), do: Repo.delete(location)
  
  def find_location(location_id) do
    case get_location(location_id) do
      nil ->
        error = Error.new("map.location.not_found", metadata: [location_id: location_id])
        {:error, error}
      location -> {:ok, location}
    end
  end

  def get_location(location_id), do: Repo.get(Location, location_id)

  def get_locations_by_ids(location_ids) do
    Location
    |> LocationQuery.by_ids(location_ids)
    |> Repo.all()
  end
end
