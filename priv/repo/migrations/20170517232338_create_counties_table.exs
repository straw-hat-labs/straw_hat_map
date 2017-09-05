defmodule StrawHat.Map.Repo.Migrations.CreateCountiesTable do
  use Ecto.Migration

  def change do
    create table(:counties) do
      add(:name, :string, null: false)
      add(:state_id, references(:states), null: false, on_delete: :delete_all)
    end

    create index(:counties, [:name, :state_id], unique: true)
  end
end
