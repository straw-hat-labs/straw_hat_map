defmodule Cargo.Repo.Migrations.CreateLocationsTable do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add(:address_id, references(:addresses), null: true)
    end
  end
end
