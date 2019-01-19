defmodule StrawHat.Map.CountriesTests do
  use StrawHat.Map.Tests.CaseTemplate, async: true
  alias StrawHat.Map.Countries

  describe "finding a country" do
    test "with a valid ID" do
      country = insert(:country)

      assert {:ok, _country} = Countries.find_country(Repo, country.id)
    end

    test "with an invalid ID" do
      country_id = Ecto.UUID.generate()
      assert {:error, _reason} = Countries.find_country(Repo, country_id)
    end
  end

  describe "getting a list of countries" do
    test "returns a pagination" do
      insert_list(6, :country)
      country_page = Countries.get_countries(Repo, %{page: 2, page_size: 5})

      assert country_page.total_entries == 6
      assert length(country_page.entries) == 1
    end
  end

  describe "getting a list of countries by IDs" do
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

  describe "creating a country" do
    test "with valid inputs" do
      params = params_for(:country)

      assert {:ok, _country} = Countries.create_country(Repo, params)
    end
  end

  describe "updating a country" do
    test "with valid inputs" do
      country = insert(:country)
      {:ok, country} = Countries.update_country(Repo, country, %{name: "Cuba"})

      assert country.name == "Cuba"
    end
  end

  describe "destroying a country" do
    test "with an existing country" do
      country = insert(:country)

      assert {:ok, _} = Countries.destroy_country(Repo, country)
    end
  end

  describe "getting a list of states by countries" do
    test "returns a list of related states" do
      countries = insert_list(2, :country)

      insert_list(2, :state, %{country: List.first(countries)})
      insert_list(2, :state, %{country: List.last(countries)})

      ids = Enum.map(countries, fn country -> country.id end)
      states = Countries.get_states(Repo, ids)

      assert length(states) == 4
    end
  end
end
