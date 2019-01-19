defmodule StrawHat.Map.Migrations.AddPostgisPlugin do
  @moduledoc """
  Enable `postgis` extension.

  Created at: ~N[2018-03-10 20:34:21]
  """

  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS postgis", "DROP EXTENSION IF EXISTS postgis")
  end
end
