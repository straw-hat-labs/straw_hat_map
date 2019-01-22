defmodule StrawHat.Map.CitiesTests do
  use StrawHat.Map.TestSupport.CaseTemplate, async: true
  alias StrawHat.Map.Cities

  describe "finding a city" do
    test "with a valid ID" do
      city = insert(:city)

      assert {:ok, _city} = Cities.find_city(Repo, city.id)
    end

    test "with an invalid ID" do
      city_id = Ecto.UUID.generate()

      assert {:error, _reason} = Cities.find_city(Repo, city_id)
    end
  end

  test "returning a pagination of cities" do
    insert_list(6, :city)
    city_page = Cities.get_cities(Repo, %{page: 2, page_size: 5})

    assert length(city_page.entries) == 1
  end

  test "creating a city with valid inputs" do
    params = params_with_assocs(:city)

    assert {:ok, _city} = Cities.create_city(Repo, params)
  end

  test "updating a city with valid inputs" do
    city = insert(:city)
    {:ok, city} = Cities.update_city(Repo, city, %{name: "Havana"})

    assert city.name == "Havana"
  end

  test "destroying an existing city" do
    city = insert(:city)

    assert {:ok, _} = Cities.destroy_city(Repo, city)
  end

  test "getting a list of cities with a list of city's IDs" do
    cities_ids =
      3
      |> insert_list(:city)
      |> Enum.map(&Map.get(&1, :id))

    found_cities_ids =
      Repo
      |> Cities.get_cities_by_ids(cities_ids)
      |> Enum.map(&Map.get(&1, :id))

    assert cities_ids == found_cities_ids
  end
end
