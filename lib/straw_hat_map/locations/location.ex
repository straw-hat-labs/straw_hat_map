defmodule StrawHat.Map.Location do
  @moduledoc """
  Represents a Location Ecto Schema with functionality about the data validation
  for Location.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.Address

  @typedoc """
  - `location`: the `Geo.Point.t/0` of the location of the Location.
  - `address`: `t:StrawHat.Map.Address.t/0` associated with the location.
  - `address_id`: `id` of `t:StrawHat.Map.Address.t/0` associated with
  the location.
  """
  @type t :: %__MODULE__{
          location: Geo.Point.t(),
          address_id: String.t(),
          address: Address.t() | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.

  - `location`: the GeoJSON Point structure for the location of the Location.
  """
  @type location_attrs :: %{
          location: Map.t(),
          address_id: String.t()
        }

  @optional_fields ~w(location address_id)a

  schema "locations" do
    field(:location, Geo.Point)
    belongs_to(:address, Address)
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Location.
  """
  @spec changeset(t, location_attrs) :: Ecto.Changeset.t()
  def changeset(location, location_attrs) do
    location
    |> cast(location_attrs, @optional_fields)
    |> cast_assoc(:address)
  end
end
