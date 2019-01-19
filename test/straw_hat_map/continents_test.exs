defmodule StrawHat.Map.ContinentsTests do
  use StrawHat.Map.TestSupport.CaseTemplate, async: true
  alias StrawHat.Map.Continents

  test "getting a list of continent's codes" do
    codes = Continents.get_continent_codes()
    assert codes == ["AF", "AN", "AS", "EU", "NA", "OC", "SA"]
  end

  test "getting the list of continents" do
    continents = Continents.get_continents()
    assert length(continents) == 7
  end

  test "finding a continent by code" do
    assert {:ok, _continent} = Continents.find_continent("AF")
    assert {:error, _continent} = Continents.find_continent("ASDF")
  end
end
