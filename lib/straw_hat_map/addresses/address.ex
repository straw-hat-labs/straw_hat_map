defmodule StrawHat.Map.Address do
  @moduledoc """
  Represents a Address Ecto Schema with functionality about the data validation
  for Address.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{City, Location}

  @typedoc """
  - `line_one`: Line one of the address.
  - `line_two`: Line two of the address.
  - `postal_code`: Postal Code or Zipcode of the address.
  - `city`: `t:StrawHat.Map.Schema.City.t/0` associated with the address.
  - `city_id`: `id` of `t:StrawHat.Map.Schema.City.t/0` associated with
  the address.
  - `locations`: List of `t:StrawHat.Map.Schema.Location.t/0` associated with
  the address.
  """
  @type t :: %__MODULE__{
          line_one: String.t(),
          line_two: String.t(),
          postal_code: String.t(),
          city: City.t() | Ecto.Association.NotLoaded.t(),
          city_id: Integer.t(),
          locations: [Location.t()] | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type address_attrs :: %{
          line_one: String.t(),
          line_two: String.t(),
          postal_code: String.t(),
          city_id: Integer.t()
        }

  @required_fields ~w(line_one city_id)a
  @optional_fields ~w(line_two postal_code)a

  schema "addresses" do
    field(:line_one, :string)
    field(:line_two, :string)
    field(:postal_code, :string)
    belongs_to(:city, City)
    has_many(:locations, Location)
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Address.
  """
  @spec changeset(t, address_attrs) :: Ecto.Changeset.t()
  def changeset(address, address_attrs) do
    address
    |> cast(address_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:city)
  end
end
