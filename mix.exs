defmodule StrawHat.Map.Mixfile do
  use Mix.Project

  @name :straw_hat_map
  @version "1.3.0"
  @elixir_version "~> 1.7"
  @source_url "https://github.com/straw-hat-team/straw_hat_map"

  def project do
    production? = Mix.env() == :prod

    [
      app: @name,
      version: @version,
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases(),
      build_embedded: production?,
      start_permanent: production?,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ],

      # Hex
      description: "Map and Addresses Management",
      package: package(),

      # Docs
      name: "StrawHat.Map",
      docs: docs()
    ]
  end

  def application do
    [mod: {StrawHat.Map.Application, []}, extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:straw_hat, "~> 0.4"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:scrivener_ecto, "~> 2.0"},
      {:geo_postgis, "~> 3.0"},

      # Testing
      {:ex_machina, ">= 0.0.0", only: [:test]},
      {:faker, ">= 0.0.0", only: [:test]},

      # Tools
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:inch_ex, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test --trace"]
    ]
  end

  defp package do
    [
      name: @name,
      files: [
        "lib",
        "priv",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["Yordis Prieto", "Osley Zorrilla"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"],
      groups_for_modules: [
        Interactors: [
          StrawHat.Map.Continents,
          StrawHat.Map.Countries,
          StrawHat.Map.States,
          StrawHat.Map.Counties,
          StrawHat.Map.Cities,
          StrawHat.Map.Locations,
          StrawHat.Map.Addresses
        ],
        Schemas: [
          StrawHat.Map.Continent,
          StrawHat.Map.Country,
          StrawHat.Map.State,
          StrawHat.Map.County,
          StrawHat.Map.City,
          StrawHat.Map.Location,
          StrawHat.Map.Address
        ]
      ]
    ]
  end
end
