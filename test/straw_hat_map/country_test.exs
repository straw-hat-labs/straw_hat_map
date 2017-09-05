defmodule StrawHatMapTest.CountryTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.Country

  test "get country by id" do
    country = insert(:country)

    assert {:ok, _country} = Country.find_country(country.id)
  end

  test "get country by invalid id" do
    assert {:error, _reason} = Country.find_country(8745)
  end

  test "list of countries" do
    insert_list(10, :country)
    country = Country.country_list(%{page: 2, page_size: 5})

    assert country.total_entries == 10
  end

  test "list of countries by ids" do
    available_countries = insert_list(3, :country)
    ids =
      available_countries
      |> Enum.take(2)
      |> Enum.map(fn country -> country.id end)
    countries = Country.get_countries_by_ids(ids)

    assert List.first(countries).id == List.first(ids)
    assert List.last(countries).id == List.last(ids)
  end

  test "create" do
    params = %{
      name: "Cuba",
      iso_two: "CU",
      iso_three: "CUB",
      iso_numeric: "192",
      continent: "NA",
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
