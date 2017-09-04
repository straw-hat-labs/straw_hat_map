defmodule StrawHat.Map.Schema.County do
  @moduledoc false
  
  use Ecto.Schema
  import Ecto.Changeset
  alias StrawHat.Map.Schema.State

  @required_fields ~w(code name state_id)a

  schema "counties" do
    field(:code, :string)
    field(:name, :string)
    belongs_to(:state, State)
  end

  def changeset(city, params \\ %{}) do
    city
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :counties_code_index)
    |> unique_constraint(:name, name: :conunties_name_state_id_index)
    |> assoc_constraint(:state)
  end
end
