defmodule StrawHat.Map.Schema.Address do
  @moduledoc false

  use StrawHat.Map.Schema
  alias StrawHat.Map.Schema.{City, Place}

  @required_fields ~w(line_one city_id)a
  @optional_fields ~w(line_two postal_code)a

  schema "addresses" do
    field(:line_one, :string)
    field(:line_two, :string)
    field(:postal_code, :string)
    belongs_to(:city, City)
    has_many(:places, Place)
  end

  def changeset(address, params \\ %{}) do
    address
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:city)
  end
end
