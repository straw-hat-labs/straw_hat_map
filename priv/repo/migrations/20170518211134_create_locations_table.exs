defmodule Cargo.Repo.Migrations.CreateLocationsTable do
  use Ecto.Migration
  defdelegate change, to: StrawHat.Map.Migrations.CreateLocationsTable
end
