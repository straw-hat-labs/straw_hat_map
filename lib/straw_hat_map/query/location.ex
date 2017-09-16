defmodule StrawHat.Map.Query.LocationQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, location_ids) do
    from location in query,
      where: location.id in ^location_ids
  end
end
