defmodule StrawHat.Map.State do
  @moduledoc """
  A State entity.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.{Country, County, City}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          code: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          country_id: String.t(),
          country: Schema.belongs_to(State.t()),
          counties: Schema.has_many(County.t()),
          cities: Schema.has_many(City.t())
        }

  @type state_attrs :: %{
          name: String.t(),
          code: String.t(),
          country_id: String.t()
        }

  @required_fields ~w(name country_id)a
  @optional_fields ~w(code)a

  schema "states" do
    field(:code, :string)
    field(:name, :string)
    belongs_to(:country, Country)
    has_many(:counties, County)
    has_many(:cities, City)
    timestamps()
  end

  @spec changeset(t, state_attrs) :: Ecto.Changeset.t()
  def changeset(state, state_attrs) do
    state
    |> cast(state_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :states_code_country_id_index)
    |> unique_constraint(:name, name: :states_name_country_id_index)
    |> assoc_constraint(:country)
  end
end
