defmodule StrawHat.Map.Query.PlaceQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Schema.Place

  @spec places_by_ids(Place.t(), [integer()]) :: Ecto.Query.t()
  def places_by_ids(query, place_ids) do
    from(place in query, where: place.id in ^place_ids)
  end

  @spec places_by_owner(Place.t(), String.t()) :: Ecto.Query.t()
  def places_by_owner(query, owner_id) do
    place in query
    |> from(where: place.owner_id == ^owner_id)
    |> places_with_location()
  end

  @spec places_with_location(Ecto.Query.t()) :: Ecto.Query.t()
  def places_with_location(query) do
    from(
      place in query,
      preload: [:location]
    )
  end
end
