defmodule StrawHat.Map.Location do
  @moduledoc """
  A location entity.
  """

  use StrawHat.Map.EctoSchema
  alias StrawHat.Map.Address

  @typedoc """
  - `location`: a GeoJSON point using `Geo.Point.t/0`.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          location: Geo.Point.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          address_id: String.t(),
          address: Schema.belongs_to(Address.t())
        }

  @type location_attrs :: %{
          location: Map.t(),
          address_id: String.t()
        }

  @optional_fields ~w(location address_id)a

  schema "locations" do
    field(:location, Geo.PostGIS.Geometry)
    belongs_to(:address, Address)
    timestamps()
  end

  @spec changeset(t, location_attrs) :: Ecto.Changeset.t()
  def changeset(location, location_attrs) do
    location
    |> cast(location_attrs, @optional_fields)
    |> cast_assoc(:address)
  end
end
