defmodule StrawHat.Map.Query.AddressQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, ids) do
    from address in query,
      where: address.id in ^ids
  end
end
