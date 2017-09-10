defmodule StrawHat.Map.Schema.Location do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{Address, Place}

  @optional_fields ~w(longitude latitude address_id)a

  schema "locations" do
    field(:longitude, :float, default: 0.0)
    field(:latitude, :float, default: 0.0)
    belongs_to(:address, Address)
    has_one(:place, Place)
  end

  def changeset(location, location_attrs) do
    location
    |> cast(location_attrs, @optional_fields)
    |> cast_assoc(:address)
  end
end
