defmodule StrawHat.Map.CountiesTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Counties

  describe "find_county/1" do
    test "with valid id should find the county" do
      county = insert(:county)

      assert {:ok, _county} = Counties.find_county(county.id)
    end

    test "with invalid id shouldn't find the county" do
      assert {:error, _reason} = Ecto.UUID.generate() |> Counties.find_county()
    end
  end

  test "get_counties/1 returns a pagination of counties" do
    insert_list(10, :county)
    county_page = Counties.get_counties(%{page: 2, page_size: 5})

    assert county_page.total_entries == 10
  end

  test "create_county/1 with valid inputs creates a county" do
    params = params_with_assocs(:county)

    assert {:ok, _county} = Counties.create_county(params)
  end

  test "update_county/2 with valid inputs updates the county" do
    county = insert(:county)
    {:ok, county} = Counties.update_county(county, %{name: "Havana"})

    assert county.name == "Havana"
  end

  test "destroy_county/1 with a found county destroys the county" do
    county = insert(:county)

    assert {:ok, _} = Counties.destroy_county(county)
  end

  test "get_counties_by_ids/1 with a list of IDs returns the relative counties" do
    available_counties = insert_list(3, :county)

    ids =
      available_counties
      |> Enum.take(2)
      |> Enum.map(fn county -> county.id end)

    counties = Counties.get_counties_by_ids(ids)

    assert List.first(counties).id == List.first(ids)
    assert List.last(counties).id == List.last(ids)
  end

  test "get_states/1 with a list of county IDs returns the relative states" do
    counties = insert_list(2, :county)

    insert_list(2, :city, %{county_id: List.first(counties).id})
    insert_list(2, :city, %{county_id: List.last(counties).id})

    ids = Enum.map(counties, fn county -> county.id end)
    cities = Counties.get_cities(ids)

    assert length(cities) == 4
  end
end
