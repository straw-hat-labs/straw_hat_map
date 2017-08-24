defmodule StrawHat.Map.Mixfile do
  use Mix.Project

  def project do
    [app: :straw_hat_map,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases()]
  end

  def application do
    [
      mod: {StrawHat.Map.Application, []},
      extra_applications: [
        :logger
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:postgrex, "~> 0.13.2"},
      {:ecto, "~> 2.1"},
      {:scrivener_ecto, "~> 1.2"},

      # Testing
      {:ex_machina, "~> 2.0", only: :test},
      {:faker, "~> 0.8", only: :test}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
