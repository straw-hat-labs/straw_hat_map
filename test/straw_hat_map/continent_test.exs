defmodule StrawHatMapTest.ContinentTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.Continent

  test "get continent codes" do
    codes = Continent.get_continent_codes()

    assert codes == ["AF", "AN", "AS", "EU", "NA", "OC", "SA"]
  end

  test "get continents" do
    continent_codes = Continent.get_continent_codes()
    continents = Continent.get_continents()

    assert Map.keys(continents) == continent_codes
  end
end
