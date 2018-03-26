defmodule StrawHat.Map.Locations do
  @moduledoc """
  Defines functionality for locations.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.Location

  @doc """
  Gets list of locations.
  """
  @since "1.0.0"
  @spec get_locations_by_ids([integer()]) :: [Location.t()] | no_return()
  def get_locations_by_ids(location_ids) do
    query = from(location in Location, where: location.id in ^location_ids)
    Repo.all(query)
  end
end
