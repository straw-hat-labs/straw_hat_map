defmodule StrawHat.Map.Query.LocationQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.Location

  @spec by_ids(Location.t(), [integer()]) :: Ecto.Query.t()
  def by_ids(query, location_ids) do
    from(location in query, where: location.id in ^location_ids)
  end
end
