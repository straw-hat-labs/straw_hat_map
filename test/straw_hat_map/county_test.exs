defmodule StrawHatMapTest.CountyTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.County

  test "get by id" do
    county = insert(:county)
    assert {:ok, _county} = County.find_county(county.id)
  end

  test "invalid id" do
    assert {:error, _reason} = County.find_county(8745)
  end

  test "list per page" do
    insert_list(10, :county)
    county = County.list_counties(%{page: 2, page_size: 5})
    assert county.total_entries == 10
  end

  test "create" do
    state = insert(:state)
    params = %{code: "001", name: "Havana", state_id: state.id}
    assert {:ok, _county} = County.create_county(params)
  end

  test "update by county" do
    county = insert(:county)
    {:ok, county} = County.update_county(county, %{"name": "Havana"})
    assert county.name == "Havana"
  end

  test "delete by county" do
    county = insert(:county)
    assert {:ok, _} = County.destroy_county(county)
  end
end
