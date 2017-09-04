defmodule StrawHat.Map.Query.Country do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, ids) do
    from country in query,
      where: country.id in ^ids
  end
end
