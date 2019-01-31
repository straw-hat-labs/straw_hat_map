defmodule StrawHat.Map.Continents do
  @moduledoc """
  Continents use cases.
  """

  alias StrawHat.{Error, Response}
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

  @spec get_continent_codes :: [String.t()]
  def get_continent_codes do
    Enum.map(@continents, fn continent -> continent.code end)
  end

  @spec get_continents :: [Continent.t()]
  def get_continents, do: @continents

  @spec find_continent(String.t()) :: Response.t(Continent.t(), Error.t())
  def find_continent(continent_code) do
    continent_code
    |> get_continent()
    |> Response.from_value(
      Error.new("straw_hat_map.continent.not_found", metadata: [continent_code: continent_code])
    )
  end

  @spec get_continent(String.t()) :: Continent.t() | nil
  def get_continent(continent_code) do
    Enum.find(@continents, fn continent ->
      continent.code == continent_code
    end)
  end
end
