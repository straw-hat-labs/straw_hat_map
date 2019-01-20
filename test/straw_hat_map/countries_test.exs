defmodule StrawHat.Map.CountriesTests do
  use StrawHat.Map.TestSupport.CaseTemplate, async: true
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

  test "returning a pagination of countries" do
    insert_list(6, :country)
    country_page = Countries.get_countries(Repo, %{page: 2, page_size: 5})

    assert length(country_page.entries) == 1
  end

  test "getting a list of countries with a list of country's IDs" do
    available_countries = insert_list(3, :country)
    ids = Enum.map(available_countries, &Map.get(&1, :id))
    countries = Countries.get_countries_by_ids(Repo, ids)

    assert available_countries == countries
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

  test "destroying an existing country" do
    country = insert(:country)

    assert {:ok, _} = Countries.destroy_country(Repo, country)
  end

  test "getting a list of states with a list of country's IDs" do
    [first_country, second_country] = insert_list(2, :country)
    insert_list(2, :state, %{country: first_country})
    insert_list(2, :state, %{country: second_country})
    states = Countries.get_states(Repo, [first_country.id, second_country.id])

    assert length(states) == 4
  end
end
