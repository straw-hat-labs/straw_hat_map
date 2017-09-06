defmodule StrawHat.Map.Schema.Location do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.Address

  @optional_fields ~w(longitude latitude address_id)a

  schema "locations" do
    field(:longitude, :float, default: 0.0)
    field(:latitude, :float, default: 0.0)
    belongs_to(:address, Address)
  end

  def changeset(location, params \\ %{}) do
    location
    |> cast(params, @optional_fields)
    |> assoc_constraint(:address)
  end
end
