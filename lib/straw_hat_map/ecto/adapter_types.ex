Postgrex.Types.define(
  StrawHat.Map.Ecto.AdapterTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Poison
)
