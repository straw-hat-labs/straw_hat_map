defmodule StrawHat.Map.Schema.Country do
  @moduledoc false
  
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(code name)a

  schema "countries" do
    field(:code, :string)
    field(:name, :string)
    field(:has_county, :boolean)
  end

  def changeset(country, params \\ %{}) do
    country
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, name: :countries_code_index)
    |> unique_constraint(:name, name: :countries_name_index)
  end
end
