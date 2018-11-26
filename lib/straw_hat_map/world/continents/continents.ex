defmodule StrawHat.Map.Continents do
  @moduledoc """
  Defines functionality for continents.
  """

  use StrawHat.Map.Interactor
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

  @doc """
  Finds a continent.
  """
  @since "1.2.1"
  @spec find_continent(String.t()) :: Response.t(Continent.t(), Error.t())
  def find_continent(continent_code) do
    continent_code
    |> get_continent()
    |> Response.from_value(
      Error.new("straw_hat_map.continent.not_found", metadata: [continent_code: continent_code])
    )
  end

  @doc """
  Gets a continent.
  """
  @since "1.2.1"
  @spec get_continent(String.t()) :: Continent.t() | nil
  def get_continent(continent_code) do
    get_continents() |> Enum.find(fn continent -> continent.code == continent_code end)
  end
end
