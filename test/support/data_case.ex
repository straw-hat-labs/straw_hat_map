defmodule StrawHatMapTest.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Query

      import StrawHatMapTest.DataCase
      import StrawHatMapTest.Factory

      alias StrawHat.Map.Repo
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(StrawHat.Map.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(StrawHat.Map.Repo, {:shared, self()})
    end

    :ok
  end
end
