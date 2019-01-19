defmodule StrawHat.Map.City do
  @moduledoc """
  A City entity.
  """

  use StrawHat.Map.EctoSchema
  alias StrawHat.Map.{Address, County, State}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          capital: boolean(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t(),
          state: Schema.belongs_to(State.t()),
          state_id: Integer.t(),
          county: Schema.belongs_to(County.t()),
          county_id: Integer.t(),
          addresses: Schema.has_many(Address.t())
        }

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
    timestamps()
  end

  @spec changeset(t, city_attrs) :: Ecto.Changeset.t()
  def changeset(city, city_attrs) do
    city
    |> cast(city_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :cities_name_state_id_index)
  end
end
