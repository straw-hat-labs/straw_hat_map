defmodule StrawHat.Map.CountiesTests do
  use StrawHat.Map.TestSupport.CaseTemplate, async: true
  alias StrawHat.Map.Counties

  describe "finding a county" do
    test "with a valid ID" do
      county = insert(:county)

      assert {:ok, _county} = Counties.find_county(Repo, county.id)
    end

    test "with an invalid ID" do
      county_id = Ecto.UUID.generate()

      assert {:error, _reason} = Counties.find_county(Repo, county_id)
    end
  end

  test "returning a pagination of counties" do
    insert_list(6, :county)
    county_page = Counties.get_counties(Repo, %{page: 2, page_size: 5})

    assert length(county_page.entries) == 1
  end

  test "creating a county with valid inputs" do
    params = params_with_assocs(:county)

    assert {:ok, _county} = Counties.create_county(Repo, params)
  end

  test "updating a county with valid inputs" do
    county = insert(:county)
    {:ok, county} = Counties.update_county(Repo, county, %{name: "Havana"})

    assert county.name == "Havana"
  end

  test "destroying an existing county" do
    county = insert(:county)

    assert {:ok, _} = Counties.destroy_county(Repo, county)
  end

  test "getting a list of counties with a list of counties's IDs" do
    counties_ids =
      3
      |> insert_list(:county)
      |> Enum.map(&Map.get(&1, :id))

    found_counties_ids =
      Repo
      |> Counties.get_counties_by_ids(counties_ids)
      |> Enum.map(&Map.get(&1, :id))

    assert counties_ids == found_counties_ids
  end

  test "getting a list of cities with a list of county's IDs" do
    [first_county, second_county] = insert_list(2, :county)
    insert_list(2, :city, %{county: first_county})
    insert_list(2, :city, %{county: second_county})
    cities = Counties.get_cities(Repo, [first_county.id, second_county.id])

    assert length(cities) == 4
  end
end
