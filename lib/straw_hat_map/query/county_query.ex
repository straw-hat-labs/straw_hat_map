defmodule StrawHat.Map.Query.CountyQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.County

  @spec counties_by_ids(County.t(), [integer()]) :: Ecto.Query.t()
  def counties_by_ids(query, county_ids) do
    from(county in query, where: county.id in ^county_ids)
  end

  @spec counties_by_states(County.t(), [integer()]) :: Ecto.Query.t()
  def counties_by_states(query, state_ids) do
    from(county in query, where: county.state_id in ^state_ids)
  end
end
