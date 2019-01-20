defmodule StrawHat.Map.LocationsTests do
  alias StrawHat.Map.{Location, Locations}
  use StrawHat.Map.TestSupport.CaseTemplate, async: true

  test "getting a list of locations with a list of locations's IDs" do
    location_ids =
      3
      |> insert_list(:location)
      |> Enum.map(&Map.get(&1, :id))

    found_locations_ids =
      Repo
      |> Locations.get_locations_by_ids(location_ids)
      |> Enum.map(&Map.get(&1, :id))

    assert location_ids == found_locations_ids
  end

  test "validating the change set with valid inputs" do
    location =
      params_for(:location, %{
        location: %{"type" => "Point", "coordinates" => [-83.550948, 22.3709423]}
      })

    assert %{valid?: true} = Location.changeset(%Location{}, location)
  end

  test "validating change set with invalid inputs" do
    invalid_location =
      params_for(:location, %{
        location: %{"type" => "PepePlz"}
      })

    assert %{valid?: false} = Location.changeset(%Location{}, invalid_location)
  end
end
