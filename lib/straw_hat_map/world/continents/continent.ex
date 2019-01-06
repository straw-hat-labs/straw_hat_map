defmodule StrawHat.Map.Continent do
  @moduledoc """
  A Continent entity.
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
