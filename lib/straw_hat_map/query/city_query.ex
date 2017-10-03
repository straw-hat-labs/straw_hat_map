defmodule StrawHat.Map.Query.CityQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, city_ids) do
    from city in query,
      where: city.id in ^city_ids
  end

  def by_state(query, state_id) do
    from city in query,
      where: city.state_id == ^state_id
  end

  def by_states(query, state_ids) do
    from city in query,
      where: city.state_id in ^state_ids
  end

  def by_counties(query, county_ids) do
    from city in query,
      where: city.county_id in ^county_ids
  end
end
