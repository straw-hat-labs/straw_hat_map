defmodule StrawHat.Map.Schema.Place do
  use Ecto.Schema
  import Ecto.Changeset
  alias StrawHat.Map.Schema.Address

  @required_fields ~w(name account_id address_id)a
  @optional_fields ~w(longitude latitude active)a

  schema "places" do
    field(:name, :string)
    field(:longitude, :float, default: 0.0)
    field(:latitude, :float, default: 0.0)
    field(:active, :boolean, default: true)
    field(:account_id, :integer)
    belongs_to(:address, Address)
  end

  def changeset(place, params \\ %{}) do
    place
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :places_name_address_id_index)
    |> assoc_constraint(:address)
  end

  def validate_address(params) do
    case Map.get(params, :address, :error) do
      :error  -> {:error, "Missing field address"}
      address -> {:ok, address}
    end
  end
end
