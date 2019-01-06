defmodule StrawHat.Map.Tests.DataCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Query

      import StrawHat.Map.Tests.DataCase
      import StrawHat.Map.Tests.Factory

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
