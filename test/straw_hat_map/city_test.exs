defmodule StrawHat.Map.Test.CityTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.City

  test "get city by id" do
    city = insert(:city)

    assert {:ok, _city} = City.find_city(city.id)
  end

  test "get city with invalid id" do
    assert {:error, _reason} = City.find_city(8745)
  end

  test "list of cities" do
    insert_list(10, :city)
    city_page = City.get_cities(%{page: 2, page_size: 5})

    assert city_page.total_entries == 10
  end

  test "create city" do
    params = params_with_assocs(:city)

    assert {:ok, _city} = City.create_city(params)
  end

  test "update city" do
    city = insert(:city)
    {:ok, city} = City.update_city(city, %{"name": "Havana"})

    assert city.name == "Havana"
  end

  test "delete city" do
    city = insert(:city)

    assert {:ok, _} = City.destroy_city(city)
  end

  test "list of cities by ids" do
    available_cities = insert_list(3, :city)
    ids =
      available_cities
      |> Enum.take(2)
      |> Enum.map(fn city -> city.id end)
    cities = City.get_cities_by_ids(ids)

    assert List.first(cities).id == List.first(ids)
    assert List.last(cities).id == List.last(ids)
  end
end
