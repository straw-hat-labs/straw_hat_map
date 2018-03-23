# StrawHat.Map

[![Build Status](https://travis-ci.org/straw-hat-team/straw_hat_map.svg?branch=master)](https://travis-ci.org/straw-hat-team/straw_hat_map)
[![codecov](https://codecov.io/gh/straw-hat-team/straw_hat_map/branch/master/graph/badge.svg)](https://codecov.io/gh/straw-hat-team/straw_hat_map)
[![Inline docs](http://inch-ci.org/github/straw-hat-team/straw_hat_map.svg)](http://inch-ci.org/github/straw-hat-team/straw_hat_map)

Application for Addresses and Map information management.

## Installation

```elixir
def deps do
  [
    {:straw_hat_map, "~> 0.3"}
  ]
end
```

### Configuration

```elixir
# In your config files

config :straw_hat_map, StrawHat.Map.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "straw_hat_map",
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  types: StrawHat.Map.Ecto.AdapterTypes
```

**Important:** Notice that we added `types: StrawHat.Map.Ecto.AdapterTypes`
to repo configuration, this is required to make PostGis to work.

## Usage

All the APIs are contain in the interactors. You would normally need to look up
in the interactor modules for the funtionalities you will need.

### Mix Aliases Task and Ecto

If you are using `Ecto` in your application probably you have some mix aliases
if not then just create it.

```elixir
# mix.exs

defp aliases do
  [
    "ecto.setup": [
      "ecto.create",
      "ecto.migrate",
      "run priv/repo/seeds.exs"
    ],
    "ecto.reset": [
      "ecto.drop",
      "ecto.setup"
    ],
    "test": ["ecto.create --quiet", "ecto.migrate", "test"]
  ]
end
```

Then add `StrawHat.Map.Repo` to the list of ecto repos on your application
in your config.

```elixir
# config/config.exs

config :my_app,
  ecto_repos: [
    # ...
    StrawHat.Map.Repo
  ]
```

This way `ecto.create`, `ecto.migrate` and `ecto.drop` knows about the repo.
