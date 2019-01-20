defmodule StrawHat.Map.TestSupport.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox
  alias StrawHat.Map.TestSupport.Repo

  using do
    quote do
      import StrawHat.Map.TestSupport.Factory
      alias StrawHat.Map.TestSupport.Repo
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
