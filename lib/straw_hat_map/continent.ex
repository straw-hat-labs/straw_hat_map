defmodule StrawHat.Map.Continent do
  @moduledoc """
  Defines functionality for continents.
  """

  alias StrawHat.Map.Schema.Continent

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
  Get list of continent codes.
  """
  @spec get_continent_codes :: [String.t()]
  def get_continent_codes do
    Enum.map(@continents, fn continent -> continent.code end)
  end

  @doc """
  Get list of continents.
  """
  @spec get_continents :: [Continent.t()]
  def get_continents, do: @continents
end
