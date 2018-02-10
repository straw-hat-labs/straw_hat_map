defmodule StrawHat.Map.Query.CountyQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, county_ids) do
    from(county in query, where: county.id in ^county_ids)
  end

  def by_states(query, state_ids) do
    from(county in query, where: county.state_id in ^state_ids)
  end
end
