defmodule StrawHat.Map.Address do
  @moduledoc """
  Represents a Address Ecto Schema with functionality about the data validation
  for Address.
  """

  use StrawHat.Map.EctoSchema
  alias StrawHat.Map.{City, Location}

  @default_postal_code_rule ~r/^\w+[ -]?\w+$/

  @type t :: %__MODULE__{
          id: String.t(),
          line_one: String.t(),
          line_two: String.t(),
          postal_code: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          city: Schema.belongs_to(City.t()),
          city_id: Integer.t(),
          locations: Schema.has_many(Location.t())
        }

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
    timestamps()
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Address.
  """
  @spec changeset(t, address_attrs, Keyword.t()) :: Ecto.Changeset.t()
  def changeset(address, address_attrs, opts \\ []) do
    address
    |> cast(address_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:city)
    |> validate_format(:postal_code, get_postal_code_rule(opts))
  end

  @doc false
  def get_postal_code_rule(opts) do
    case Keyword.get(opts, :postal_code_rule) do
      nil -> @default_postal_code_rule
      value -> value
    end
  end

  @doc false
  def default_postal_code_rule, do: @default_postal_code_rule
end
