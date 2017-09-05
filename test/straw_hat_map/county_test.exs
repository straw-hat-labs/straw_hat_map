defmodule StrawHatMapTest.CountyTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.County

  test "get county by id" do
    county = insert(:county)

    assert {:ok, _county} = County.find_county(county.id)
  end

  test "get county by invalid id" do
    assert {:error, _reason} = County.find_county(8745)
  end

  test "list of counties" do
    insert_list(10, :county)
    county_page = County.get_counties(%{page: 2, page_size: 5})

    assert county_page.total_entries == 10
  end

  test "create county" do
    params = params_with_assocs(:county)

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

  test "list of counties by ids" do
    available_counties = insert_list(3, :county)
    ids =
      available_counties
      |> Enum.take(2)
      |> Enum.map(fn county -> county.id end)
    counties = County.get_counties_by_ids(ids)

    assert List.first(counties).id == List.first(ids)
    assert List.last(counties).id == List.last(ids)
  end

  test "list of cities by county ids" do
    counties = insert_list(2, :county)

    insert_list(2, :city, %{county_id: List.first(counties).id})
    insert_list(2, :city, %{county_id: List.last(counties).id})

    ids =
      counties
      |> Enum.map(fn county -> county.id end)

    cities = County.get_cities_by_counties(ids)

    assert length(cities) ==  4
  end
end
