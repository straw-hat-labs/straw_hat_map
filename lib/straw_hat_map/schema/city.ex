defmodule StrawHat.Map.Schema.City do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{County, State}

  @required_fields ~w(name state_id)a
  @optional_fields ~w(county_id)a

  schema "cities" do
    field(:name, :string)
    belongs_to(:state, State)
    belongs_to(:county, County)
  end

  def changeset(city, params \\ %{}) do
    city
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :cities_name_state_id_index)
  end
end
