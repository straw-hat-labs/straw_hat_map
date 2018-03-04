defmodule StrawHat.Map.Place do
  @moduledoc """
  Defines functionality for places management.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.PlaceQuery
  alias StrawHat.Map.Schema.Place

  @doc """
  Get the list of places.
  """
  @spec get_places(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_places(pagination \\ []), do: Repo.paginate(Place, pagination)

  @doc """
  Create a place.
  """
  @spec create_place(Place.place_attrs()) :: {:ok, Place.t()} | {:error, Ecto.Changeset.t()}
  def create_place(place_attrs) do
    %Place{}
    |> Place.create_changeset(place_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a place.
  """
  @spec update_place(Place.t(), Place.place_attrs()) ::
          {:ok, Place.t()} | {:error, Ecto.Changeset.t()}
  def update_place(%Place{} = place, place_attrs) do
    place
    |> Place.update_changeset(place_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a place.
  """
  @spec destroy_place(Place.t()) :: {:ok, Place.t()} | {:error, Ecto.Changeset.t()}
  def destroy_place(%Place{} = place), do: Repo.delete(place)

  @doc """
  Get a place by `id`.
  """
  @spec find_place(String.t()) :: {:ok, Place.t()} | {:error, Error.t()}
  def find_place(place_id) do
    case get_place(place_id) do
      nil ->
        error = Error.new("straw_hat_map.place.not_found", metadata: [place_id: place_id])
        {:error, error}

      place ->
        {:ok, place}
    end
  end

  @doc """
  Get a place by `id`.
  """
  @spec get_place(String.t()) :: Place.t() | nil | no_return
  def get_place(place_id) do
    Place
    |> PlaceQuery.places_with_location()
    |> Repo.get(place_id)
  end

  @spec get_places_by_owner(integer(), Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_places_by_owner(owner_id, pagination \\ []) do
    Place
    |> PlaceQuery.places_by_owner(owner_id)
    |> Repo.paginate(pagination)
  end

  @doc """
  Get list of places.
  """
  @spec get_places_by_ids([integer()]) :: [Place.t()] | no_return()
  def get_places_by_ids(place_ids) do
    Place
    |> PlaceQuery.places_by_ids(place_ids)
    |> Repo.all()
  end
end
