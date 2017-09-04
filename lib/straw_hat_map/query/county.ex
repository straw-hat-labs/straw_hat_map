defmodule StrawHat.Map.Query.County do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, ids) do
    from county in query,
      where: county.id in ^ids
  end

  def by_states(query, ids) do
    from county in query,
      where: county.state_id in ^ids
  end
end
