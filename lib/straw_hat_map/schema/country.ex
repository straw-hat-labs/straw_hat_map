defmodule StrawHat.Map.Schema.Country do
  @moduledoc false

  use StrawHat.Map.Schema

  alias StrawHat.Map.Continent
  alias StrawHat.Map.Schema.State

  @continent_codes Continent.get_continent_codes()
  @required_fields ~w(name iso_two iso_three iso_numeric continent)a
  @optional_fields ~w(has_counties)a

  schema "countries" do
    field(:name, :string)
    field(:iso_two, :string)
    field(:iso_three, :string)
    field(:iso_numeric, :string)
    field(:continent, :string)
    field(:has_counties, :boolean)
    has_many(:states, State)
  end

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
