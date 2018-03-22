defmodule StrawHat.Map.CitiesTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Cities

  describe "get city by id" do
    test "with valid id" do
      city = insert(:city)

      assert {:ok, _city} = Cities.find_city(city.id)
    end

    test "with invalid id" do
      assert {:error, _reason} = Cities.find_city(8745)
    end
  end

  test "get list of cities" do
    insert_list(5, :city)
    city_page = Cities.get_cities(%{page: 2, page_size: 2})

    assert length(city_page.entries) == 2
  end

  test "create a city" do
    params = params_with_assocs(:city)

    assert {:ok, _city} = Cities.create_city(params)
  end

  test "update a city" do
    city = insert(:city)
    {:ok, city} = Cities.update_city(city, %{name: "Havana"})

    assert city.name == "Havana"
  end

  test "destroy a city" do
    city = insert(:city)

    assert {:ok, _} = Cities.destroy_city(city)
  end

  test "get list of cities by ids" do
    available_cities = insert_list(3, :city)

    ids =
      available_cities
      |> Enum.take(2)
      |> Enum.map(fn city -> city.id end)

    cities = Cities.get_cities_by_ids(ids)

    assert List.first(cities).id == List.first(ids)
    assert List.last(cities).id == List.last(ids)
  end
end
