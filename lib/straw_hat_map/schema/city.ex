defmodule StrawHat.Map.Schema.City do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{County, State}

  @required_fields ~w(code name)a
  @optional_fields ~w(state_id county_id)a

  schema "cities" do
    field(:code, :string)
    field(:name, :string)
    belongs_to(:state, State)
    belongs_to(:county, County)
  end

  def changeset(city, params \\ %{}) do
    city
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :cities_code_index)
  end
end
