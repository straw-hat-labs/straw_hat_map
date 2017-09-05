defmodule StrawHat.Map.Repo.Migrations.CreateCountriesTable do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add(:name, :string, null: false)

      add(:iso_two, :string, null: false, size: 2)
      add(:iso_three, :string, null: false, size: 3)
      add(:iso_numeric, :string, null: false, size: 3)

      add(:has_county, :boolean, default: false)
    end

    create index(:countries, [:name], unique: true)
    create index(:countries, [:iso_two], unique: true)
    create index(:countries, [:iso_three], unique: true)
    create index(:countries, [:iso_numeric], unique: true)
  end
end
