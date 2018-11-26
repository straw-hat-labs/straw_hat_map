defmodule StrawHat.Map.Country do
  @moduledoc """
  Represents a Country Ecto Schema with functionality about the data validation
  for Country.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.{Continents, State}
  alias StrawHat.Map.Ecto.Regex

  @typedoc """
  - `id`: ID of the country.
  - `name`: Name of the country.
  - `iso_two`: Two characters ISO code.
  - `iso_three`: Three characters ISO code.
  - `iso_numeric`: Numeric ISO code.
  - `has_counties`: Defines if the country has counties.
  - `continent`: Two characters continent code.
  - `inserted_at`: When the country was created.
  - `updated_at`: Last time the country was updated.
  - `states`: List of `t:StrawHat.Map.States.t/0` associated with
  the country.
  - `postal_code_rule`: A regular expression that specifies a valid postal code.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          iso_two: String.t(),
          iso_three: String.t(),
          iso_numeric: String.t(),
          continent: String.t(),
          has_counties: boolean(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          states: Schema.has_many(State.t()),
          postal_code_rule: Regex.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type country_attrs :: %{
          name: String.t(),
          iso_two: String.t(),
          iso_three: String.t(),
          iso_numeric: String.t(),
          continent: String.t(),
          has_counties: boolean(),
          postal_code_rule: Regex.t()
        }

  @continent_codes Continents.get_continent_codes()
  @required_fields ~w(name iso_two iso_three iso_numeric continent)a
  @optional_fields ~w(has_counties postal_code_rule)a

  schema "countries" do
    field(:name, :string)
    field(:iso_two, :string)
    field(:iso_three, :string)
    field(:iso_numeric, :string)
    field(:continent, :string)
    field(:has_counties, :boolean)
    field(:postal_code_rule, Regex)
    has_many(:states, State)
    timestamps()
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Country.
  """
  @since "1.0.0"
  @spec changeset(t, country_attrs) :: Ecto.Changeset.t()
  def changeset(country, country_attrs) do
    country
    |> cast(country_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_name()
    |> validate_iso_two()
    |> validate_iso_three()
    |> validate_iso_numeric()
    |> validate_inclusion(:continent, @continent_codes)
  end

  defp validate_name(changeset) do
    changeset
    |> update_change(:name, &String.trim/1)
    |> update_change(:name, &String.capitalize/1)
    |> unique_constraint(:name)
  end

  defp validate_iso_two(changeset) do
    changeset
    |> update_change(:iso_two, &String.trim/1)
    |> update_change(:iso_two, &String.upcase/1)
    |> validate_format(:iso_two, ~r/^\w{2}$/)
    |> unique_constraint(:iso_two)
  end

  defp validate_iso_three(changeset) do
    changeset
    |> update_change(:iso_three, &String.trim/1)
    |> update_change(:iso_three, &String.upcase/1)
    |> validate_format(:iso_three, ~r/^\w{3}$/)
    |> unique_constraint(:iso_three)
  end

  defp validate_iso_numeric(changeset) do
    changeset
    |> update_change(:iso_numeric, &String.trim/1)
    |> validate_format(:iso_numeric, ~r/^\d{3}$/)
    |> unique_constraint(:iso_numeric)
  end
end
