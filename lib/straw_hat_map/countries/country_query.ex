defmodule StrawHat.Map.Query.CountryQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.Country

  @spec countries_by_ids(Country.t(), [integer()]) :: Ecto.Query.t()
  def countries_by_ids(query, country_ids) do
    from(country in query, where: country.id in ^country_ids)
  end
end
