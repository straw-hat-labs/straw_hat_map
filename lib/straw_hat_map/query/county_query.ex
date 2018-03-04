defmodule StrawHat.Map.Query.CountyQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.County

  @spec by_ids(County.t(), [integer()]) :: Ecto.Query.t()
  def by_ids(query, county_ids) do
    from(county in query, where: county.id in ^county_ids)
  end

  @spec by_states(County.t(), [integer()]) :: Ecto.Query.t()
  def by_states(query, state_ids) do
    from(county in query, where: county.state_id in ^state_ids)
  end
end
