defmodule StrawHat.Map.Query.AddressQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.Address

  @spec by_ids(Address.t(), [integer()]) :: Ecto.Query.t()
  def by_ids(query, address_ids) do
    from(address in query, where: address.id in ^address_ids)
  end
end
