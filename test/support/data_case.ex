defmodule StrawHat.Map.Tests.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox
  alias StrawHat.Map.Repo

  using do
    quote do
      import StrawHat.Map.Tests.Factory
      alias StrawHat.Map.Repo
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async] do
      Sandbox.mode(Repo, {:shared, self()})
    end

    :ok
  end
end
