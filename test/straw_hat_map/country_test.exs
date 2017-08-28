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
    params = %{code: "001", name: "Cuba"}
    assert {:ok, _country} = Country.create_country(params)
  end

  test "update by entity" do
    country = insert(:country)
    {:ok, country} = Country.update_country(country, %{"name": "Cuba"})
    assert country.name == "Cuba"
  end

  test "update by id" do
    country = insert(:country)
    {:ok, country} = Country.update_country(country.id, %{"name": "Cuba"})
    assert country.name == "Cuba"
  end

  test "update by invalid id" do
    {:error, _} = Country.update_country(99999, %{})
  end

  test "delete country by id" do
    country = insert(:country)
    assert {:ok, _} = Country.destroy_country(country.id)
  end
end
