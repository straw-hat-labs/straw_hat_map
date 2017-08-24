defmodule StrawHat.Map.Repo.Migrations.CreateCitiesTable do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add(:code, :string, null: false)
      add(:name, :string, null: false)
      add(:state_id, references(:states), null: true)
      add(:county_id, references(:counties), null: true)
    end

    create index(:cities, [:code], unique: true)
  end
end
