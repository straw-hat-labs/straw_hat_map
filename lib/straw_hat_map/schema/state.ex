defmodule StrawHat.Map.Schema.State do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias StrawHat.Map.Schema.Country

  @required_fields ~w(code name country_id)a

  schema "states" do
    field(:code, :string)
    field(:name, :string)
    belongs_to(:country, Country)
  end

  def changeset(state, params \\ %{}) do
    state
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :states_code_index)
    |> unique_constraint(:name, name: :states_name_country_id_index)
    |> assoc_constraint(:country)
  end
end
