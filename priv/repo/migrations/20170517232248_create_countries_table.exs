defmodule StrawHat.Map.Repo.Migrations.CreateCountriesTable do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add(:code, :string, null: false)
      add(:name, :string, null: false)
      add(:has_county, :boolean, default: false)
    end

    create index(:countries, [:code], unique: true)
    create index(:countries, [:name], unique: true)
  end
end
