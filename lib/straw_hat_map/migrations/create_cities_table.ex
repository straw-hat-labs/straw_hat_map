defmodule StrawHat.Map.Migrations.CreateCitiesTable do
  use Ecto.Migration

  @id 20170517232349

  def change do
    create table(:cities, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:capital, :boolean, default: false)
      add(:state_id, references(:states, type: :binary_id, on_delete: :delete_all), null: false)
      add(:county_id, references(:counties, type: :binary_id), null: true)
      timestamps(type: :utc_datetime)
    end

    create(index(:cities, [:name, :state_id], unique: true))
  end
end
