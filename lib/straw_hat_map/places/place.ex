defmodule StrawHat.Map.Schema.Place do
  @moduledoc """
  Represents a Place Ecto Schema with functionality about the data validation
  for Place.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{Place}
  alias StrawHat.Map.{Location}

  @typedoc """
  - `name`: Name of the place.
  - `place`: `t:StrawHat.Map.Schema.Place.t/0` associated with the current place.
  It is usefule when something is a place is located inside another place
  on the system.
  - `place_id`: `id` of `t:StrawHat.Map.Schema.Place.t/0` associated with
  the place.
  - `location`: `t:StrawHat.Map.Location.t/0` associated with the
  current location.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          place_id: String.t(),
          place: State.t() | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type place_attrs :: %{
          name: String.t(),
          owner_id: String.t(),
          place_id: String.t()
        }

  @required_fields ~w(name owner_id)a
  @optional_fields ~w(place_id)a

  schema "places" do
    field(:name, :string)
    field(:owner_id, :string)
    belongs_to(:place, Place)
    belongs_to(:location, Location)
  end

  @spec changeset(t, place_attrs) :: Ecto.Changeset.t()
  def changeset(place, place_attrs) do
    place
    |> cast(place_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :places_name_place_id_index)
    |> unique_constraint(:name, name: :places_name_owner_id_index)
    |> assoc_constraint(:place)
  end

  @spec create_changeset(t, place_attrs) :: Ecto.Changeset.t()
  def create_changeset(place, place_attrs) do
    place
    |> changeset(place_attrs)
    |> cast_assoc(:location, required: true)
  end

  @spec update_changeset(t, place_attrs) :: Ecto.Changeset.t()
  def update_changeset(place, place_attrs) do
    place
    |> changeset(place_attrs)
    |> cast_assoc(:location)
  end
end
