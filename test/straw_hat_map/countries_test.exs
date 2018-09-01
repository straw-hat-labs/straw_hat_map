defmodule StrawHat.Map.CountriesTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Countries

  describe "find_country/1" do
    test "with valid id should find the country" do
      country = insert(:country)

      assert {:ok, _country} = Countries.find_country(country.id)
    end

    test "with invalid id shouldn't find the country" do
      assert {:error, _reason} = Ecto.UUID.generate() |> Countries.find_country()
    end
  end

  test "get_countries/1 returns a pagination of countries" do
    insert_list(6, :country)
    country_page = Countries.get_countries(%{page: 2, page_size: 5})

    assert country_page.total_entries == 6
    assert length(country_page.entries) == 1
  end

  test "get_countries_by_ids/1 with a list of IDs returns the relative countries" do
    available_countries = insert_list(3, :country)

    ids =
      available_countries
      |> Enum.take(2)
      |> Enum.map(fn country -> country.id end)

    countries = Countries.get_countries_by_ids(ids)

    assert List.first(countries).id == List.first(ids)
    assert List.last(countries).id == List.last(ids)
  end

  test "create_country/1 with valid inputs creates a country" do
    params = params_for(:country)

    assert {:ok, _country} = Countries.create_country(params)
  end

  test "update_country/2 with valid inputs updates the country" do
    country = insert(:country)
    {:ok, country} = Countries.update_country(country, %{name: "Cuba"})

    assert country.name == "Cuba"
  end

  test "destroy_country/1 with a found country destroys the country" do
    country = insert(:country)

    assert {:ok, _} = Countries.destroy_country(country)
  end

  test "get_states/1 with a list of country IDs returns the relative states" do
    countries = insert_list(2, :country)

    insert_list(2, :state, %{country: List.first(countries)})
    insert_list(2, :state, %{country: List.last(countries)})

    ids = Enum.map(countries, fn country -> country.id end)
    states = Countries.get_states(ids)

    assert length(states) == 4
  end
end