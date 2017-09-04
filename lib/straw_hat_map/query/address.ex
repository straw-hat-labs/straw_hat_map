defmodule StrawHat.Map.Query.Address do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  def by_ids(query, ids) do
    from address in query,
      where: address.id in ^ids
  end
end
