defmodule StrawHat.Map.Migrations.CreateLocationsTable do
  @moduledoc """
  Create locations table.

  Created at: ~N[2017-05-18 21:11:34]
  """

  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add(:id, :binary_id, primary_key: true)

      add(
        :address_id,
        references(:addresses, type: :binary_id, on_delete: :delete_all),
        null: true
      )

      timestamps(type: :utc_datetime)
    end
  end
end
