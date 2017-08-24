defmodule Cargo.Repo.Migrations.CreatePlacesTable do
  use Ecto.Migration

  def change do
    create table(:places) do
      add(:name, :string, null: false)
      add(:longitude, :float)
      add(:latitude, :float)
      add(:active, :boolean, null: false, default: true)
      add(:account_id, :integer, null: false)
      add(:address_id, references(:addresses), null: false)
    end

    create index(:places, [:name, :address_id], unique: true)
  end
end
