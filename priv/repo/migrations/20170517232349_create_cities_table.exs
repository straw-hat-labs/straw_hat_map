defmodule StrawHat.Map.Repo.Migrations.CreateCitiesTable do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add(:name, :string, null: false)
      add(:state_id, references(:states), null: false)
      add(:county_id, references(:counties), null: true)
    end

    create index(:cities, [:name, :state_id], unique: true)
  end
end
