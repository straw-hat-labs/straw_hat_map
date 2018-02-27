defmodule StrawHat.Map.Test.CityTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.City

  describe "get city by id" do
    test "with valid id" do
      city = insert(:city)

      assert {:ok, _city} = City.find_city(city.id)
    end

    test "with invalid id" do
      assert {:error, _reason} = City.find_city(8745)
    end
  end

  test "get list of cities" do
    insert_list(5, :city)
    city_page = City.get_cities(%{page: 2, page_size: 2})

    assert length(city_page.entries) == 2
  end

  test "create city" do
    params = params_with_assocs(:city)

    assert {:ok, _city} = City.create_city(params)
  end

  test "update city" do
    city = insert(:city)
    {:ok, city} = City.update_city(city, %{name: "Havana"})

    assert city.name == "Havana"
  end

  test "destroy city" do
    city = insert(:city)

    assert {:ok, _} = City.destroy_city(city)
  end

  test "get list of cities by ids" do
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
