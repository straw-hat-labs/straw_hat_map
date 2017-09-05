defmodule StrawHat.Map.Repo.Migrations.CreateStatesTable do
  use Ecto.Migration

  def change do
    create table(:states) do
      add(:code, :string)
      add(:name, :string, null: false)
      add(:country_id, references(:countries), null: false)
    end

    create index(:states, [:code, :country_id], unique: true)
    create index(:states, [:name, :country_id], unique: true)
  end
end
