defmodule StrawHat.Map.Migrations.CreateCountriesTable do
  @moduledoc false

  use Ecto.Migration

  @id ~N[2017-05-17 23:20:48]

  def change do
    create table(:countries, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)

      add(:iso_two, :string, null: false, size: 2)
      add(:iso_three, :string, null: false, size: 3)
      add(:iso_numeric, :string, null: false, size: 3)

      add(:continent, :string, null: false, size: 2)
      add(:has_counties, :boolean, default: false)
      timestamps(type: :utc_datetime)
    end

    create(index(:countries, [:name], unique: true))
    create(index(:countries, [:iso_two], unique: true))
    create(index(:countries, [:iso_three], unique: true))
    create(index(:countries, [:iso_numeric], unique: true))
  end
end
