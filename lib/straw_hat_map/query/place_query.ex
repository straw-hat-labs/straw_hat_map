defmodule StrawHat.Map.Query.PlaceQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.Place

  @spec by_ids(Place.t(), [integer()]) :: Ecto.Query.t()
  def by_ids(query, place_ids) do
    from(place in query, where: place.id in ^place_ids)
  end

  @spec by_owner(Place.t(), String.t()) :: Ecto.Query.t()
  def by_owner(query, owner_id) do
    from(place in query, where: place.owner_id == ^owner_id)
  end

  @spec with_location(Ecto.Query.t()) :: Ecto.Query.t()
  def with_location(query) do
    from(
      place in query,
      left_join: location in assoc(place, :location),
      left_join: address in assoc(location, :address),
      preload: [location: {location, address: address}]
    )
  end
end
