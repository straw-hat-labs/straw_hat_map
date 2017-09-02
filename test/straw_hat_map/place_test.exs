defmodule StrawHatMapTest.PlaceTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.Place

  test "get by id" do
    place = insert(:place)
    assert {:ok, _place} = Place.find_place(place.id)
  end

  test "invalid id" do
    assert {:error, _reason} = Place.find_place(8745)
  end

  test "list per page" do
    insert_list(10, :place)
    place = Place.list_places(%{page: 2, page_size: 5})
    assert place.total_entries == 10
  end

  test "create" do
    address = insert(:address)
    params = %{name: "Home", account_id: 1, address_id: address.id}
    assert {:ok, _place} = Place.create_place(params)
  end

  test "update by place" do
    place = insert(:place)
    {:ok, place} = Place.update_place(place, %{"name": "Home"})
    assert place.name == "Home"
  end

  test "delete by place" do
    place = insert(:place)
    assert {:ok, _} = Place.destroy_place(place)
  end
end
