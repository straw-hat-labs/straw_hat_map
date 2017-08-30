defmodule StrawHat.IAM.Query.City do
  import Ecto.Query, only: [from: 2]

  def by_ids(query, ids) do
    from city in query,
      where: city.id in ^ids
  end

  def by_state(query, state_id) do
    from city in query,
      where: city.state_id == ^state_id
  end

  def by_states(query, state_ids) do
    from city in query,
      where: city.state_id in ^state_ids
  end

  def by_countries(query, country_ids) do
    from city in query,
      where: city.county_id in ^country_ids
  end
end
