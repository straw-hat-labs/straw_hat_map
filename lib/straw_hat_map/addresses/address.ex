defmodule StrawHat.Map.Address do
  @moduledoc """
  Represents a Address Ecto Schema with functionality about the data validation
  for Address.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.{City, Location}

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
  @spec changeset(t, address_attrs) :: Ecto.Changeset.t()
  def changeset(address, address_attrs) do
    address
    |> cast(address_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:city)
    |> validate_postal_code()
  end

  @spec validate_postal_code(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_postal_code(changeset) do
    rule =
      get_field(changeset, :city_id)
      |> get_postal_code_rule()

    changeset
    |> validate_format(:postal_code, rule)
  end

  @spec get_postal_code_rule(Integer.t()) :: City.t() | nil | no_return
  defp get_postal_code_rule(city) do
    %City{state: %StrawHat.Map.State{country: %StrawHat.Map.Country{postal_code_rule: rule}}} =
      StrawHat.Map.Repo.get!(City, city)
      |> StrawHat.Map.Repo.preload([state: :country])
    case rule do
      nil -> ~r/^\w+[ -]?\w+$/
      _ -> rule
    end
  end
end