defmodule StrawHat.Map.Migrations.CreateAddressesTable do
  @moduledoc """
  Create addresses table.

  Created at: ~N[2017-05-17 23:24:15]
  """

  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:line_one, :string, null: false)
      add(:line_two, :string)
      add(:postal_code, :string)
      add(:city_id, references(:cities, type: :binary_id), null: false)
      timestamps(type: :utc_datetime)
    end
  end
end
