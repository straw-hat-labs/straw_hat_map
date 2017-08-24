defmodule StrawHat.Map.Repo.Migrations.CreateCountiesTable do
  use Ecto.Migration

  def change do
    create table(:counties) do
      add(:code, :string, null: false)
      add(:name, :string, null: false)
      add(:state_id, references(:states), null: false)
    end

    create index(:counties, [:code], unique: true)
    create index(:counties, [:name, :state_id], unique: true)
  end
end
