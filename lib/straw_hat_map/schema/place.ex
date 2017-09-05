defmodule StrawHat.Map.Schema.Place do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.Address

  @required_fields ~w(name owner_id address_id)a
  @optional_fields ~w(longitude latitude active)a

  schema "places" do
    field(:name, :string)
    field(:longitude, :float, default: 0.0)
    field(:latitude, :float, default: 0.0)
    field(:active, :boolean, default: true)
    field(:owner_id, :string)
    belongs_to(:address, Address)
  end

  def changeset(place, params \\ %{}) do
    place
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :places_name_address_id_index)
    |> assoc_constraint(:address)
  end
end
