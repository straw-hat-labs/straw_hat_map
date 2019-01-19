defmodule StrawHat.Map.Migrations.AddPostgisPlugin do
  @moduledoc false

  use Ecto.Migration

  @id ~N[2018-03-10 20:34:21]

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS postgis", "DROP EXTENSION IF EXISTS postgis")
  end
end
