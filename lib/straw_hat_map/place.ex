defmodule StrawHat.Map.Place do
  import Ecto.Query, only: [from: 2]

  alias StrawHat.Error
  alias Ecto.Multi
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.Place
  alias StrawHat.Map.Schema.Address

  def list_places(params), do: Repo.paginate(Place, params)

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
  def update_place(id, params) do
    with {:ok, place} <- find_place(id),
      do: update_place(place, params)
  end

  def destroy_place(%Place{} = place) do
    address = Repo.get(Address, place.address_id)
    multi =
      Multi.new
      |> Multi.delete(:place, place)
      |> Multi.delete(:address, address)
    case Repo.transaction(multi) do
      {:ok, result} -> {:ok, result[:place]}
      _ -> {:error,Error.new("map.place.destroy_failed", metadata: [id: place.id])}
    end
  end
  def destroy_place(id) do
    with {:ok, place} <- find_place(id),
      do: destroy_place(place)
  end

  def destroy_places(place_ids) do
    place_query =
      (from p in Place,
      where: p.id in ^place_ids)
    places = Repo.all(place_query)

    address_ids = Enum.map(places, fn(place) -> place.address_id end)
    address_query =
      (from a in Address,
      where: a.id in ^address_ids)

    transaction =
      Ecto.Multi.new()
      |> Ecto.Multi.delete_all(:place, place_query)
      |> Ecto.Multi.delete_all(:address, address_query)
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

  def get_place(id),
    do: Repo.get(Place, id)

  def get_places_by_account(id)do
    query =
      from p in Place,
      where: [account_id: ^id]
    Repo.all(query)
  end
  def get_places_by_account(id, params)do
    query =
      from p in Place,
      where: [account_id: ^id]
    Repo.paginate(query, params)
  end

  def place_by_ids(place_ids) do
    query =
      from p in Place,
      where: p.id in ^place_ids
    Repo.all(query)
  end
end
