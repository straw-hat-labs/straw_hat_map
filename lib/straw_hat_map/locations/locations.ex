defmodule StrawHat.Map.Locations do
  @moduledoc """
  Location management use cases.
  """

  import Ecto.Query, only: [from: 2]
  alias StrawHat.Map.Location

  @spec get_locations_by_ids(Ecto.Repo.t(), [integer()]) :: [Location.t()] | no_return()
  def get_locations_by_ids(repo, location_ids) do
    query = from(location in Location, where: location.id in ^location_ids)
    repo.all(query)
  end
end
