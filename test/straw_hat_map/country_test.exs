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
    country_page = Country.get_countries(%{page: 2, page_size: 5})

    assert country_page.total_entries == 10
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

  test "create country" do
    params = params_for(:country)

    assert {:ok, _country} = Country.create_country(params)
  end

  test "update country" do
    country = insert(:country)
    {:ok, country} = Country.update_country(country, %{"name": "Cuba"})

    assert country.name == "Cuba"
  end

  test "delete country" do
    country = insert(:country)

    assert {:ok, _} = Country.destroy_country(country)
  end

  test "list of states by country ids" do
    countries = insert_list(2, :country)

    insert_list(2, :state, %{country: List.first(countries)})
    insert_list(2, :state, %{country: List.last(countries)})

    ids =
      countries
      |> Enum.map(fn country -> country.id end)

    states = Country.get_states_by_countries(ids)

    assert length(states) ==  4
  end
end
