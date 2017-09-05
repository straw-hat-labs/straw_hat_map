defmodule StrawHat.Map.Schema.State do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.Country

  @required_fields ~w(name country_id)a
  @optional_fields ~w(code)a

  schema "states" do
    field(:code, :string)
    field(:name, :string)
    belongs_to(:country, Country)
  end

  def changeset(state, params \\ %{}) do
    state
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :states_code_country_id_index)
    |> unique_constraint(:name, name: :states_name_country_id_index)
    |> assoc_constraint(:country)
  end
end
