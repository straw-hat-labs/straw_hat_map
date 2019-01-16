defmodule StrawHat.Map.County do
  @moduledoc """
  A County entity.
  """

  use StrawHat.Map.EctoSchema
  alias StrawHat.Map.State

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          state: Schema.belongs_to(State.t()),
          state_id: String.t()
        }

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

  @spec changeset(t, county_attrs) :: Ecto.Changeset.t()
  def changeset(city, county_attrs) do
    city
    |> cast(county_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :conunties_name_state_id_index)
    |> assoc_constraint(:state)
  end
end
