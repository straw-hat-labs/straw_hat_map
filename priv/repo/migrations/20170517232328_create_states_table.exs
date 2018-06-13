defmodule StrawHat.Map.Repo.Migrations.CreateStatesTable do
  use Ecto.Migration

  def change do
    create table(:states, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:code, :string)
      add(:name, :string, null: false)

      add(
        :country_id,
        references(:countries, type: :binary_id, on_delete: :delete_all),
        null: false
      )

      timestamps(type: :utc_datetime)
    end

    create(index(:states, [:code, :country_id], unique: true))
    create(index(:states, [:name, :country_id], unique: true))
  end
end
