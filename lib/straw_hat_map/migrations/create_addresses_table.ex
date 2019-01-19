defmodule StrawHat.Map.Migrations.CreateAddressesTable do
  @moduledoc false

  use Ecto.Migration

  @id 20170517232415

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
