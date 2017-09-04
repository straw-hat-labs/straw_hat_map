defmodule StrawHat.Map.Place do
  alias StrawHat.Map.Query.Place, as: PlaceQuery
  alias StrawHat.Map.Query.Address, as: AddressQuery
  alias StrawHat.Error
  alias Multi
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.Place
  alias StrawHat.Map.Schema.Address

  def list_places(paginate), do: Repo.paginate(Place, paginate)

  def create_place(params) do
    %Place{}
    |> Place.changeset(params)
    |> Repo.insert()
  end

  def update_place(%Place{} = place, params) do
    place
    |> Place.changeset(params)
    |> Repo.update()
  end

  def destroy_place(%Place{} = place) do
    address = Repo.get(Address, place.address_id)
    multi =
      Multi.new
      |> Multi.delete(:place, place)
      |> Multi.delete(:address, address)
    case Repo.transaction(multi) do
      {:ok, result} -> {:ok, result[:place]}
      _ -> {:error, Error.new("map.place.destroy_failed", metadata: [id: place.id])}
    end
  end

  def destroy_places(place_ids) do
    place_query = PlaceQuery.by_ids(Place, place_ids)
    places = Repo.all(place_query)

    address_ids = Enum.map(places, fn(place) -> place.address_id end)
    address_query = AddressQuery.by_ids(Address, address_ids)

    transaction =
      Multi.new()
      |> Multi.delete_all(:place, place_query)
      |> Multi.delete_all(:address, address_query)
    case Repo.transaction(transaction) do
      {:ok, places} -> {:ok, places}
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, Error.new("map.place.destroy_places_failed", metadata: [failed_value: failed_value])}
    end
  end

  def find_place(id) do
    case get_place(id) do
      nil -> {:error, Error.new("map.place.not_found", metadata: [id: id])}
      place -> {:ok, place}
    end
  end

  def get_place(id), do: Repo.get(Place, id)

  def get_places_by_account(id)do
    Place
    |> PlaceQuery.by_account(id)
    |> Repo.all()
  end
  def get_places_by_account(id, paginate)do
    Place
    |> PlaceQuery.by_account(id)
    |> Repo.paginate(paginate)
  end

  def place_by_ids(place_ids) do
    Place
    |> PlaceQuery.by_ids(place_ids)
    |> Repo.all()
  end
end
