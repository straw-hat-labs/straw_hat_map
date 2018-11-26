defmodule StrawHat.Map.County do
  @moduledoc """
  Represents a County Ecto Schema with functionality about the data validation
  for County.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.State

  @typedoc """
  - `id`: ID of the county.
  - `name`: Name of the county.
  - `inserted_at`: When the county was created.
  - `updated_at`: Last time the county was updated.
  - `state`: `t:StrawHat.Map.State.t/0` associated with the county.
  - `state_id`: `id` of `t:StrawHat.Map.State.t/0` associated with
  the county.
  """
  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          state: Schema.belongs_to(State.t()),
          state_id: String.t()
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
    timestamps()
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current County.
  """
  @since "1.0.0"
  @spec changeset(t, county_attrs) :: Ecto.Changeset.t()
  def changeset(city, county_attrs) do
    city
    |> cast(county_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :conunties_name_state_id_index)
    |> assoc_constraint(:state)
  end
end
