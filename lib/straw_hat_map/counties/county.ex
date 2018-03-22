defmodule StrawHat.Map.County do
  @moduledoc """
  Represents a County Ecto Schema with functionality about the data validation
  for County.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.State

  @typedoc """
  - `name`: Name of the county.
  - `state`: `t:StrawHat.Map.Schema.State.t/0` associated with the county.
  - `state_id`: `id` of `t:StrawHat.Map.Schema.State.t/0` associated with
  the county.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          state_id: String.t(),
          state: State.t() | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type county_attrs :: %{
          name: String.t(),
          state_id: String.t()
        }

  @required_fields ~w(name state_id)a

  schema "counties" do
    field(:name, :string)
    belongs_to(:state, State)
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current County.
  """
  @spec changeset(t, county_attrs) :: Ecto.Changeset.t()
  def changeset(city, county_attrs) do
    city
    |> cast(county_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :conunties_name_state_id_index)
    |> assoc_constraint(:state)
  end
end
