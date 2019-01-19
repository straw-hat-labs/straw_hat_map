deps:
	mix local.hex --force
	mix local.rebar --force
	mix deps.get

linter:
	mix compile --warnings-as-errors --force
	mix format --check-formatted
	mix credo --strict

testing:
	mix coveralls.json

ci: deps linter testing
