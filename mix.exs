defmodule StrawHat.Map.Mixfile do
  use Mix.Project

  @organization "straw_hat"
  @name :straw_hat_map
  @version "0.2.2"
  @elixir_version "~> 1.5"

  @description """
    Addresses Management.
  """
  @source_url "https://github.com/straw-hat-team/straw_hat_map"

  def project do
    production? = Mix.env == :prod

    [
      name: "StrawHat.Map",
      description: @description,

      app: @name,
      version: @version,
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env),
      deps: deps(),
      aliases: aliases(),

      build_embedded: production?,
      start_permanent: production?,

      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.html": :test
      ],

      # Extras
      package: package(),
      docs: docs()
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
      {:straw_hat, "~> 0.1.2"},

      {:postgrex, "~> 0.13.2"},
      {:ecto, "~> 2.2"},
      {:scrivener_ecto, "~> 1.2"},

      # Testing
      {:ex_machina, ">= 0.0.0", only: [:test]},
      {:faker, ">= 0.0.0", only: [:test]},

      # Tools
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
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
        "priv",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["Yordis Prieto"],
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
      extras: ["README.md"]
    ]
  end
end
