defmodule StrawHat.Map.Migrations.AddPostgisPlugin do
  use Ecto.Migration

  @id 20180310203421

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS postgis")
  end

  def down do
    execute("DROP EXTENSION IF EXISTS postgis")
  end
end
