defmodule StrawHat.Map.Continent do
  alias StrawHat.Map.Schema.Continent

  @continents %{
    "AF" => %Continent{code: "AF", name: "Africa"},
    "AN" => %Continent{code: "AN", name: "Antarctica"},
    "AS" => %Continent{code: "AS", name: "Asia"},
    "EU" => %Continent{code: "EU", name: "Europe"},
    "NA" => %Continent{code: "NA", name: "North America"},
    "OC" => %Continent{code: "OC", name: "Oceania"},
    "SA" => %Continent{code: "SA", name: "South America"}
  }

  def get_continent_codes, do: Map.keys(@continents)

  def get_continents, do: @continents
end
