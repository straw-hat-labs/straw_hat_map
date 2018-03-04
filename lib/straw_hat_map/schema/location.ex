defmodule StrawHat.Map.Schema.Location do
  @moduledoc """
  Represents a Location Ecto Schema with functionality about the data validation
  for Location.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{Address, Place}

  @typedoc """
  - `longitude`: Longitude of the location.
  - `latitude`: Latitude of the location.
  - `address`: `t:StrawHat.Map.Schema.Address.t/0` associated with the location.
  - `address_id`: `id` of `t:StrawHat.Map.Schema.Address.t/0` associated with
  the location.
  - `place`: `t:StrawHat.Map.Schema.Place.t/0` associated with the location.
  """
  @type t :: %__MODULE__{
          longitude: float(),
          latitude: float(),
          address_id: String.t(),
          address: Address.t() | Ecto.Association.NotLoaded.t(),
          place: Place.t() | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type location_attrs :: %{
          longitude: float(),
          latitude: float(),
          address_id: String.t()
        }

  @optional_fields ~w(longitude latitude address_id)a

  schema "locations" do
    field(:longitude, :float, default: 0.0)
    field(:latitude, :float, default: 0.0)
    belongs_to(:address, Address)
    has_one(:place, Place)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Location.
  """
  @spec changeset(t, location_attrs) :: Ecto.Changeset.t()
  def changeset(location, location_attrs) do
    location
    |> cast(location_attrs, @optional_fields)
    |> cast_assoc(:address)
  end
end
