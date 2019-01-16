defmodule StrawHat.Map.EctoSchema do
  @moduledoc false

  @type belongs_to(t) :: t | Ecto.Association.NotLoaded.t()
  @type has_many(t) :: [t] | Ecto.Association.NotLoaded.t()

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime, usec: true]
    end
  end
end
