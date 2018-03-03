defmodule StrawHat.Map.Schema.Continent do
  @moduledoc """
  Represents a Content struct.
  """

  @typedoc """
  - `name`: Name of the continent.
  - `code`: Two characters code of the continent.
  """
  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
        }

  @enforce_keys [:code]
  defstruct [:code, :name]
end
