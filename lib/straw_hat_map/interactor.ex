defmodule StrawHat.Map.Interactor do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      import Ecto.Query, only: [from: 2]
      alias StrawHat.Error
      alias StrawHat.Map.Repo
    end
  end
end
