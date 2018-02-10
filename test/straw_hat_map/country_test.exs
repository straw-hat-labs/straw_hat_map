defmodule StrawHat.Map.Test.CountryTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Country

  describe "get country by id" do
    test "with valid id" do
      country = insert(:country)

      assert {:ok, _country} = Country.find_country(country.id)
    end

    test "with invalid id" do
      assert {:error, _reason} = Country.find_country(8745)
    end
  end

  test "get list of countries" do
    insert_list(6, :country)
    country_page = Country.get_countries(%{page: 2, page_size: 5})

    assert country_page.total_entries == 6
    assert length(country_page.entries) == 1
  end

  test "get list of countries by ids" do
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
    {:ok, country} = Country.update_country(country, %{name: "Cuba"})

    assert country.name == "Cuba"
  end

  test "destroy country" do
    country = insert(:country)

    assert {:ok, _} = Country.destroy_country(country)
  end

  test "get list of states by country ids" do
    countries = insert_list(2, :country)

    insert_list(2, :state, %{country: List.first(countries)})
    insert_list(2, :state, %{country: List.last(countries)})

    ids = Enum.map(countries, fn country -> country.id end)
    states = Country.get_states(ids)

    assert length(states) == 4
  end
end
