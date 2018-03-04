defmodule StrawHat.Map.Continent do
  @moduledoc """
  Defines functionality for continents.
  """

  alias StrawHat.Map.Schema.Continent

  @continents [
    %Continent{code: "AF", name: "Africa"},
    %Continent{code: "AN", name: "Antarctica"},
    %Continent{code: "AS", name: "Asia"},
    %Continent{code: "EU", name: "Europe"},
    %Continent{code: "NA", name: "North America"},
    %Continent{code: "OC", name: "Oceania"},
    %Continent{code: "SA", name: "South America"}
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
