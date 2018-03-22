defmodule StrawHat.Map.State do
  @moduledoc """
  Represents a State Ecto Schema with functionality about the data validation
  for State.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.{Country, County, City}

  @typedoc """
  - `name`: Name of the state.
  - `code`: Code of the state.
  - `country`: `t:StrawHat.Map.Country.t/0` associated with the current
  state.
  - `country_id`: `id` of `t:StrawHat.Map.Country.t/0` associated with
  the state.
  - `counties`: List of `t:StrawHat.Map.County.t/0` associated with the
  current state.
  - `cities`: List of `t:StrawHat.Map.City.t/0` associated with the
  current state.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          code: String.t(),
          country_id: String.t(),
          country: State.t() | Ecto.Association.NotLoaded.t(),
          counties: [County.t()] | Ecto.Association.NotLoaded.t(),
          cities: [City.t()] | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
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
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current State.
  """
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
