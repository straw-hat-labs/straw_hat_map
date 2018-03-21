defmodule StrawHat.Map.Location do
  @moduledoc """
  Defines functionality for locations.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.LocationQuery
  alias StrawHat.Map.Schema.Location

  @doc """
  Get list of locations.
  """
  @spec get_locations_by_ids([integer()]) :: [Location.t()] | no_return()
  def get_locations_by_ids(location_ids) do
    Location
    |> LocationQuery.locations_by_ids(location_ids)
    |> Repo.all()
  end
end
