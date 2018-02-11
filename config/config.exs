use Mix.Config

config :straw_hat_map, ecto_repos: [StrawHat.Map.Repo]

config :straw_hat_map, StrawHat.Map.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "straw_hat_map_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :error
