defmodule StrawHat.Map.Locations do
  @moduledoc """
  Locations management use cases.
  """

  import Ecto.Query
  alias StrawHat.Map.Location

  @spec get_locations_by_ids(Ecto.Repo.t(), [integer()]) :: [Location.t()] | no_return()
  def get_locations_by_ids(repo, location_ids) do
    Location
    |> select([location], location)
    |> where([location], location.id in ^location_ids)
    |> repo.all()
  end
end
