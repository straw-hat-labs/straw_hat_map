defmodule StrawHatMapTest.CountryTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.Country

  test "get by id" do
    country = insert(:country)
    assert {:ok, _country} = Country.find_country(country.id)
  end

  test "invalid id" do
    assert {:error, _reason} = Country.find_country(8745)
  end

  test "list per page" do
    insert_list(10, :country)
    country = Country.list_countries(%{page: 2, page_size: 5})
    assert country.total_entries == 10
  end

  test "create" do
    params = %{
      name: "Cuba",
      iso_two: "CU",
      iso_three: "CUB",
      iso_numeric: "192",
      has_county: true}

    assert {:ok, _country} = Country.create_country(params)
  end

  test "update by country" do
    country = insert(:country)
    {:ok, country} = Country.update_country(country, %{"name": "Cuba"})
    assert country.name == "Cuba"
  end

  test "delete country" do
    country = insert(:country)
    assert {:ok, _} = Country.destroy_country(country)
  end
end
