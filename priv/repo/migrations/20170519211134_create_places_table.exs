defmodule Cargo.Repo.Migrations.CreatePlacesTable do
  use Ecto.Migration

  def change do
    create table(:places) do
      add(:name, :string, null: false)
      add(:owner_id, :string, null: false)

      add(:place_id, references(:places), null: true)
      add(:location_id, references(:locations), null: true)
    end

    create index(:places, [:name, :place_id], unique: true)
    create index(:places, [:name, :owner_id], unique: true)
  end
end
