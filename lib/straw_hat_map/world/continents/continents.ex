defmodule StrawHat.Map.Continents do
  @moduledoc """
  Defines functionality for continents.
  """

  alias StrawHat.Map.Continent

  @continents [
    %Continent{code: "AF"},
    %Continent{code: "AN"},
    %Continent{code: "AS"},
    %Continent{code: "EU"},
    %Continent{code: "NA"},
    %Continent{code: "OC"},
    %Continent{code: "SA"}
  ]

  @doc """
  Returns the list of continent codes.
  """
  @since "1.0.0"
  @spec get_continent_codes :: [String.t()]
  def get_continent_codes do
    Enum.map(@continents, fn continent -> continent.code end)
  end

  @doc """
  Returns the list of continents.
  """
  @since "1.0.0"
  @spec get_continents :: [Continent.t()]
  def get_continents, do: @continents
end
