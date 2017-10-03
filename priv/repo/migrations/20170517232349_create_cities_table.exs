defmodule StrawHat.Map.Repo.Migrations.CreateCitiesTable do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add(:name, :string, null: false)
      add(:capital, :boolean, default: false)
      add(:state_id, references(:states), null: false, on_delete: :delete_all)
      add(:county_id, references(:counties), null: true)
    end

    create index(:cities, [:name, :state_id], unique: true)
  end
end
