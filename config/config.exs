use Mix.Config

config :straw_hat_map, ecto_repos: [StrawHat.Map.Repo]

config :straw_hat_map, StrawHat.Map.Repo,
  database: "straw_hat_map",
  pool: Ecto.Adapters.SQL.Sandbox,
  types: StrawHat.Map.TestSupport.DatabaseAdapterTypes

config :logger, level: :warn
