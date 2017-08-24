use Mix.Config

config :straw_hat_map,
  ecto_repos: [StrawHat.Map.Repo]

import_config "#{Mix.env}.exs"
