defmodule StrawHat.Map.Query.StateQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.State

  @spec states_by_ids(State.t(), [integer()]) :: Ecto.Query.t()
  def states_by_ids(query, ids) do
    from(state in query, where: state.id in ^ids)
  end

  @spec states_by_countries(State.t(), [integer()]) :: Ecto.Query.t()
  def states_by_countries(query, country_ids) do
    from(state in query, where: state.country_id in ^country_ids)
  end
end
