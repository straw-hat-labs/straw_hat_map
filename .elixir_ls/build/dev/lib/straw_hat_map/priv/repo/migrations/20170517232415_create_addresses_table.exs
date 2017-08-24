defmodule StrawHat.Map.Repo.Migrations.CreateAddressesTable do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add(:line_one, :string, null: false)
      add(:line_two, :string)
      add(:postal_code, :string)
      add(:city_id, references(:cities), null: false)
    end
  end
end
