defmodule StrawHatMapTest.PlaceTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.Place

  test "get place by id" do
    place = insert(:place)

    assert {:ok, _place} = Place.find_place(place.id)
  end

  test "get place by invalid id" do
    assert {:error, _reason} = Place.find_place(8745)
  end

  test "places list" do
    insert_list(7, :place)
    place = Place.get_places(%{page: 2, page_size: 5})

    assert length(place.entries) == 2
  end

  test "create place" do
    address = insert(:address)
    params = %{name: "Home", owner_id: "1", address_id: address.id}

    assert {:ok, _place} = Place.create_place(params)
  end

  test "update place" do
    place = insert(:place)
    {:ok, place} = Place.update_place(place, %{"name": "Home"})

    assert place.name == "Home"
  end

  test "delete place" do
    place = insert(:place)

    assert {:ok, _} = Place.destroy_place(place)
  end

  test "list of places by ids" do
    available_places = insert_list(3, :place)
    ids =
      available_places
      |> Enum.take(2)
      |> Enum.map(fn place -> place.id end)
    places = Place.get_places_by_ids(ids)

    assert List.first(places).id == List.first(ids)
    assert List.last(places).id == List.last(ids)
  end


  test "list of places by owner" do
    insert_list(1, :place)
    insert_list(2, :place, %{owner_id: "5"})

    place_page = Place.get_places_by_owner("5")

    assert length(place_page.entries) == 2
  end
end
