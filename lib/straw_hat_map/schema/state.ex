defmodule StrawHat.Map.Schema.State do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{Country, County, City}

  @required_fields ~w(name country_id)a
  @optional_fields ~w(code)a

  schema "states" do
    field(:code, :string)
    field(:name, :string)
    belongs_to(:country, Country)
    has_many(:counties, County)
    has_many(:cities, City)
  end

  def changeset(state, state_attrs) do
    state
    |> cast(state_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :states_code_country_id_index)
    |> unique_constraint(:name, name: :states_name_country_id_index)
    |> assoc_constraint(:country)
  end
end
