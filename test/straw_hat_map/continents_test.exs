defmodule StrawHat.Map.ContinentsTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Continents

  test "get_continent_codes/0 fetch the list of continent codes" do
    codes = Continents.get_continent_codes()

    assert codes == ["AF", "AN", "AS", "EU", "NA", "OC", "SA"]
  end

  test "get_continents/0 fetch the list of continents" do
    continents = Continents.get_continents()

    assert length(continents) == 7
  end
end
