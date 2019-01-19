defmodule StrawHat.Map.CitiesTest do
  use StrawHat.Map.Tests.CaseTemplate, async: true
  alias StrawHat.Map.Cities

  describe "find_city/1" do
    test "with valid id should find the city" do
      city = insert(:city)

      assert {:ok, _city} = Cities.find_city(Repo, city.id)
    end

    test "with invalid id shouldn't find the city" do
      city_id = Ecto.UUID.generate()
      assert {:error, _reason} = Cities.find_city(Repo, city_id)
    end
  end

  test "get_cities/1 returns a pagination of cities" do
    insert_list(5, :city)
    city_page = Cities.get_cities(Repo, %{page: 2, page_size: 2})

    assert length(city_page.entries) == 2
  end

  test "create_city/1 with valid inputs creates a city" do
    params = params_with_assocs(:city)

    assert {:ok, _city} = Cities.create_city(Repo, params)
  end

  test "update_city/2 with valid inputs updates the city" do
    city = insert(:city)
    {:ok, city} = Cities.update_city(Repo, city, %{name: "Havana"})

    assert city.name == "Havana"
  end

  test "destroy_city/1 with a found city destroys the city" do
    city = insert(:city)

    assert {:ok, _} = Cities.destroy_city(Repo, city)
  end

  test "get_cities_by_ids/1 with a list of IDs returns the relative cities" do
    available_cities = insert_list(3, :city)

    ids =
      available_cities
      |> Enum.take(2)
      |> Enum.map(fn city -> city.id end)

    cities = Cities.get_cities_by_ids(Repo, ids)

    assert List.first(cities).id == List.first(ids)
    assert List.last(cities).id == List.last(ids)
  end
end
