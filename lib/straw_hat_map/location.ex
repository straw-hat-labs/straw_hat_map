defmodule StrawHat.Map.Location do
  @moduledoc false
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.LocationQuery
  alias StrawHat.Map.Schema.Location

  def get_locations_by_ids(location_ids) do
    Location
    |> LocationQuery.by_ids(location_ids)
    |> Repo.all()
  end
end
