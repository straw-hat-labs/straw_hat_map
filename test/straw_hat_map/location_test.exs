defmodule StrawHat.Map.Test.LocationTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Schema.Location, as: LocationSchema
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

  describe "changeset/2" do
    test "with valid data" do
      location =
        params_for(:location, %{
          location: %{"type" => "Point", "coordinates" => [-83.550948, 22.3709423]}
        })

      assert %{valid?: true} = LocationSchema.changeset(%LocationSchema{}, location)
    end

    test "with invalid data" do
      invalid_location =
        params_for(:location, %{
          location: %{"type" => "PepePlz"}
        })

      assert %{valid?: false} = LocationSchema.changeset(%LocationSchema{}, invalid_location)
    end
  end
end
