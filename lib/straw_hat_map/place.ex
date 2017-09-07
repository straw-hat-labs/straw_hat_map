defmodule StrawHat.Map.Place do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.PlaceQuery
  alias StrawHat.Map.Schema.Place

  def get_places(pagination), do: Repo.paginate(Place, pagination)

  def create_place(place_attrs) do
    %Place{}
    |> Place.changeset(place_attrs)
    |> Repo.insert()
  end

  def update_place(%Place{} = place, place_attrs) do
    place
    |> Place.changeset(place_attrs)
    |> Repo.update()
  end

  def destroy_place(%Place{} = place), do: Repo.delete(place)

  def find_place(place_id) do
    case get_place(place_id) do
      nil ->
        error = Error.new("map.place.not_found", metadata: [place_id: place_id])
        {:error, error}
      place -> {:ok, place}
    end
  end

  def get_place(place_id), do: Repo.get(Place, place_id)

  def get_places_by_owner(owner_id, pagination \\ []) do
    Place
    |> PlaceQuery.by_owner(owner_id)
    |> Repo.paginate(pagination)
  end

  def get_places_by_ids(place_ids) do
    Place
    |> PlaceQuery.by_ids(place_ids)
    |> Repo.all()
  end
end
