use Mix.Config

config :straw_hat_map, ecto_repos: [StrawHat.Map.TestSupport.Repo]

config :straw_hat_map, StrawHat.Map.TestSupport.Repo,
  database: "straw_hat_map",
  pool: Ecto.Adapters.SQL.Sandbox,
  types: StrawHat.Map.TestSupport.DatabaseAdapterTypes

config :logger, level: :warn
