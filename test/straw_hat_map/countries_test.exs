defmodule StrawHat.Map.CountriesTest do
  use StrawHat.Map.Tests.DataCase, async: true
  alias StrawHat.Map.Countries
  alias StrawHat.Map.Repo

  describe "find_country" do
    test "with valid id should find the country" do
      country = insert(:country)

      assert {:ok, _country} = Countries.find_country(Repo, country.id)
    end

    test "with invalid id shouldn't find the country" do
      country_id = Ecto.UUID.generate()
      assert {:error, _reason} = Countries.find_country(Repo, country_id)
    end
  end

  describe "get_countries" do
    test "returns a pagination of countries" do
      insert_list(6, :country)
      country_page = Countries.get_countries(Repo, %{page: 2, page_size: 5})

      assert country_page.total_entries == 6
      assert length(country_page.entries) == 1
    end
  end

  describe "get_countries_by_ids" do
    test "with a list of IDs returns the relative countries" do
      available_countries = insert_list(3, :country)

      ids =
        available_countries
        |> Enum.take(2)
        |> Enum.map(fn country -> country.id end)

      countries = Countries.get_countries_by_ids(Repo, ids)

      assert List.first(countries).id == List.first(ids)
      assert List.last(countries).id == List.last(ids)
    end
  end

  describe "create_country" do
    test "with valid inputs creates a country" do
      params = params_for(:country)

      assert {:ok, _country} = Countries.create_country(Repo, params)
    end
  end

  describe "update_country" do
    test "with valid inputs updates the country" do
      country = insert(:country)
      {:ok, country} = Countries.update_country(Repo, country, %{name: "Cuba"})

      assert country.name == "Cuba"
    end
  end

  describe "destroy_country" do
    test "with a found country destroys the country" do
      country = insert(:country)

      assert {:ok, _} = Countries.destroy_country(Repo, country)
    end
  end

  describe "get_states" do
    test "with a list of country IDs returns the relative states" do
      countries = insert_list(2, :country)

      insert_list(2, :state, %{country: List.first(countries)})
      insert_list(2, :state, %{country: List.last(countries)})

      ids = Enum.map(countries, fn country -> country.id end)
      states = Countries.get_states(Repo, ids)

      assert length(states) == 4
    end
  end
end
