defmodule StrawHat.Map.Test.ContinentTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Continent

  test "get continent codes" do
    codes = Continent.get_continent_codes()

    assert codes == ["AF", "AN", "AS", "EU", "NA", "OC", "SA"]
  end

  test "get continents" do
    continents = Continent.get_continents()

    assert length(continents) == 7
  end
end
