defmodule StrawHat.Map.Continent do
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

  def get_continent_codes do
    Enum.map(@continents, fn continent -> continent.code end)
  end

  def get_continents, do: @continents
end
