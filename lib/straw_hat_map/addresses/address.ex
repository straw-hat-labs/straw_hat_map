defmodule StrawHat.Map.Address do
  @moduledoc """
  Represents a Address Ecto Schema with functionality about the data validation
  for Address.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.{City, Location}

  @default_postal_code_rule ~r/^\w+[ -]?\w+$/

  @typedoc """
  - `line_one`: Line one of the address.
  - `line_two`: Line two of the address.
  - `postal_code`: Postal Code or Zipcode of the address.
  - `city`: `t:StrawHat.Map.City.t/0` associated with the address.
  - `city_id`: `id` of `t:StrawHat.Map.City.t/0` associated with
  the address.
  - `locations`: List of `t:StrawHat.Map.Location.t/0` associated with
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
  @since "1.0.0"
  @spec changeset(t, address_attrs, Keyword.t()) :: Ecto.Changeset.t()
  def changeset(address, address_attrs, opts \\ []) do
    address
    |> cast(address_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:city)
    |> validate_format(:postal_code, get_postal_code_rule(opts))
  end

  @doc false
  @since "1.1.0"
  @spec get_postal_code_rule(Keyword.t()) :: Regex.t()
  def get_postal_code_rule(opts) do
    case Keyword.get(opts, :postal_code_rule) do
      nil -> @default_postal_code_rule
      value -> value
    end
  end

  @doc false
  @since "1.1.0"
  @spec default_postal_code_rule :: Regex.t()
  def default_postal_code_rule, do: @default_postal_code_rule
end
