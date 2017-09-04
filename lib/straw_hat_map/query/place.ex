defmodule StrawHat.Map.Query.PlaceQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, ids) do
    from place in query,
      where: place.id in ^ids
  end

  def by_account(query, id) do
    from p in query,
      where: [account_id: ^id]
  end
end
