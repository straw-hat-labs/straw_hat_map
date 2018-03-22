defmodule StrawHat.Map.Schema.City do
  @moduledoc """
  Represents a City Ecto Schema with functionality about the data validation
  for City.
  """

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{County, State, Address}

  @typedoc """
  - `name`: Name of the city.
  - `capital`: Defines the city as capital of the country.
  - `state`: `t:StrawHat.Map.Schema.State.t/0` associated with the city.
  - `state_id`: `id` of `t:StrawHat.Map.Schema.State.t/0` associated with
  the city.
  - `county`: `t:StrawHat.Map.County.t/0` associated with the city.
  - `county_id`: `id` of `t:StrawHat.Map.County.t/0` associated with
  the city.
  - `addresses`: List of `t:StrawHat.Map.Schema.Address.t/0` associated with
  the city.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          capital: boolean(),
          state: State.t() | Ecto.Association.NotLoaded.t(),
          state_id: Integer.t(),
          county: County.t() | Ecto.Association.NotLoaded.t(),
          county_id: Integer.t(),
          addresses: [Address.t()]
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type city_attrs :: %{
          name: String.t(),
          capital: boolean(),
          state_id: Integer.t(),
          county_id: Integer.t()
        }

  @required_fields ~w(name state_id)a
  @optional_fields ~w(county_id capital)a

  schema "cities" do
    field(:name, :string)
    field(:capital, :boolean)
    belongs_to(:state, State)
    belongs_to(:county, County)
    has_many(:addresses, Address)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current City.
  """
  @spec changeset(t, city_attrs) :: Ecto.Changeset.t()
  def changeset(city, city_attrs) do
    city
    |> cast(city_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :cities_name_state_id_index)
  end
end
