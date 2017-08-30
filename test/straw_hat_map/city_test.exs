defmodule StrawHatMapTest.CityTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.City

  test "get by id" do
    city = insert(:city)
    assert {:ok, _city} = City.find_city(city.id)
  end

  test "invalid id" do
    assert {:error, _reason} = City.find_city(8745)
  end

  test "list per page" do
    insert_list(10, :city)
    city = City.list_cities(%{page: 2, page_size: 5})
    assert city.total_entries == 10
  end

  test "create" do
    county = insert(:county)
    params = %{code: "001", name: "Havana", county_id: county.id}
    assert {:ok, _city} = City.create_city(params)
  end

  test "update by entity" do
    city = insert(:city)
    {:ok, city} = City.update_city(city, %{"name": "Havana"})
    assert city.name == "Havana"
  end

  test "update by id" do
    city = insert(:city)
    {:ok, city} = City.update_city(city, %{"name": "Havana"})
    assert city.name == "Havana"
  end

  test "delete city by id" do
    city = insert(:city)
    assert {:ok, _} = City.destroy_city(city)
  end
end
