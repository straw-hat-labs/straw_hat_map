defmodule StrawHat.Map.Schema.County do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.State

  @required_fields ~w(name state_id)a

  schema "counties" do
    field(:name, :string)
    belongs_to(:state, State)
  end

  def changeset(city, params \\ %{}) do
    city
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :conunties_name_state_id_index)
    |> assoc_constraint(:state)
  end
end
