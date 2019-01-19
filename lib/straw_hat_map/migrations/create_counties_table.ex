defmodule StrawHat.Map.Migrations.CreateCountiesTable do
  @moduledoc """
  Create counties table.

  Created at: ~N[2017-05-17 23:23:38]
  """

  use Ecto.Migration

  def change do
    create table(:counties, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)

      add(
        :state_id,
        references(:states, type: :binary_id, on_delete: :delete_all),
        null: false
      )

      timestamps(type: :utc_datetime)
    end

    create(index(:counties, [:name, :state_id], unique: true))
  end
end
