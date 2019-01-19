defmodule StrawHat.Map.LocationsTest do
  use StrawHat.Map.Tests.CaseTemplate, async: true
  alias StrawHat.Map.{Location, Locations}

  test "get_locations_by_ids/1 with a list of IDs returns the relative locations" do
    available_locations = insert_list(3, :location)

    ids =
      available_locations
      |> Enum.take(2)
      |> Enum.map(fn location -> location.id end)

    locations = Locations.get_locations_by_ids(Repo, ids)

    assert List.first(locations).id == List.first(ids)
    assert List.last(locations).id == List.last(ids)
  end

  describe "changeset/2" do
    test "with valid data returns a valid changeset" do
      location =
        params_for(:location, %{
          location: %{"type" => "Point", "coordinates" => [-83.550948, 22.3709423]}
        })

      assert %{valid?: true} = Location.changeset(%Location{}, location)
    end

    test "with invalid data returns an invalid changeset" do
      invalid_location =
        params_for(:location, %{
          location: %{"type" => "PepePlz"}
        })

      assert %{valid?: false} = Location.changeset(%Location{}, invalid_location)
    end
  end
end
