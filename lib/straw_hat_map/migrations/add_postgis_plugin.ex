defmodule StrawHat.Map.Migrations.AddPostgisPlugin do
  @moduledoc false

  use Ecto.Migration

  @id 20180310203421

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS postgis", "DROP EXTENSION IF EXISTS postgis")
  end
end
