defmodule StrawHat.Map.Continent do
  @moduledoc """
  Represents a Content struct.
  """

  @typedoc """
  - `code`: Two characters code of the continent.
  """
  @type t :: %__MODULE__{
          code: String.t()
        }

  @enforce_keys [:code]
  defstruct [:code]
end
