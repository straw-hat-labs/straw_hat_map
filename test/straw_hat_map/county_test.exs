defmodule StrawHat.Map.CountiesTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Counties

  describe "get county by id" do
    test "with valid id" do
      county = insert(:county)

      assert {:ok, _county} = Counties.find_county(county.id)
    end

    test "with invalid id" do
      assert {:error, _reason} = Counties.find_county(8745)
    end
  end

  test "get list of counties" do
    insert_list(10, :county)
    county_page = Counties.get_counties(%{page: 2, page_size: 5})

    assert county_page.total_entries == 10
  end

  test "create a county" do
    params = params_with_assocs(:county)

    assert {:ok, _county} = Counties.create_county(params)
  end

  test "update a county" do
    county = insert(:county)
    {:ok, county} = Counties.update_county(county, %{name: "Havana"})

    assert county.name == "Havana"
  end

  test "destroy a county" do
    county = insert(:county)

    assert {:ok, _} = Counties.destroy_county(county)
  end

  test "list of counties by ids" do
    available_counties = insert_list(3, :county)

    ids =
      available_counties
      |> Enum.take(2)
      |> Enum.map(fn county -> county.id end)

    counties = Counties.get_counties_by_ids(ids)

    assert List.first(counties).id == List.first(ids)
    assert List.last(counties).id == List.last(ids)
  end

  test "list of cities by county ids" do
    counties = insert_list(2, :county)

    insert_list(2, :city, %{county_id: List.first(counties).id})
    insert_list(2, :city, %{county_id: List.last(counties).id})

    ids = Enum.map(counties, fn county -> county.id end)
    cities = Counties.get_cities(ids)

    assert length(cities) == 4
  end
end
