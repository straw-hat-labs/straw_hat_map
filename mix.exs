defmodule StrawHat.Map.Mixfile do
  use Mix.Project

  @version "0.2.1"

  @elixir_version "~> 1.5"
  @name :straw_hat_map
  @organization "straw_hat"
  @description """
    Addresses Management
  """
  @source_url "https://github.com/straw-hat-llc/straw_hat_map"

  def project do
    production? = Mix.env == :prod

    [
      app: @name,
      description: @description,
      version: @version,
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: production?,
      start_permanent: production?,
      deps: deps(),
      aliases: aliases(),
      package: package(),

      # docs
      name: "StrawHat.Map",
      source_url: @source_url,
      homepage_url: @source_url,
      docs: [
        main: "StrawHat.Map",
        extras: ["README.md"]
      ],

      # coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [mod: {StrawHat.Map.Application, []},
     extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:straw_hat, "~> 0.0.9", organization: "straw_hat"},

      {:postgrex, "~> 0.13.2"},
      {:ecto, "~> 2.2"},
      {:scrivener_ecto, "~> 1.2"},

      # Testing
      {:ex_machina, ">= 0.0.0", only: :test},
      {:faker, ">= 0.0.0", only: :test},

      # Tools
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: :test}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test --trace"]]
  end

  defp package do
    [
      name: @name,
      organization: @organization,
      files: [
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["Yordis Prieto"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
