defmodule StrawHat.Map.Test.LocationTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Location

  test "get locations by ids" do
    available_locations = insert_list(3, :location)
    ids =
      available_locations
      |> Enum.take(2)
      |> Enum.map(fn location -> location.id end)
    locations = Location.get_locations_by_ids(ids)

    assert List.first(locations).id == List.first(ids)
    assert List.last(locations).id == List.last(ids)
  end
end
