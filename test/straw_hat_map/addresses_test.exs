defmodule StrawHat.Map.AddressesTests do
  use StrawHat.Map.TestSupport.CaseTemplate, async: true
  alias StrawHat.Map.{Address, Addresses, Countries}

  describe "finding an address" do
    test "with a valid ID" do
      address = insert(:address)

      assert {:ok, _address} = Addresses.find_address(Repo, address.id)
    end

    test "with an invalid ID" do
      id = Ecto.UUID.generate()

      assert {:error, _reason} = Addresses.find_address(Repo, id)
    end
  end

  test "returning a pagination of addresses" do
    insert_list(6, :address)
    address_page = Addresses.get_addresses(Repo, %{page: 2, page_size: 5})

    assert length(address_page.entries) == 1
  end

  test "creating an address with valid inputs" do
    params = params_with_assocs(:address)

    assert {:ok, _address} = Addresses.create_address(Repo, params)
  end

  test "updating an address with valid inputs" do
    new_city = insert(:city)
    address = insert(:address)

    {:ok, address} =
      Addresses.update_address(Repo, address, %{
        line_two: "PO BOX 123",
        city_id: new_city.id
      })

    assert address.line_two == "PO BOX 123"
  end

  test "destroying an exsiting address" do
    address = insert(:address)

    assert {:ok, _} = Addresses.destroy_address(Repo, address)
  end

  test "getting a list of addresses with a list of address's IDs" do
    addresses_ids =
      3
      |> insert_list(:address)
      |> Enum.map(&Map.get(&1, :id))

    found_addresses_ids =
      Repo
      |> Addresses.get_addresses_by_ids(addresses_ids)
      |> Enum.map(&Map.get(&1, :id))

    assert addresses_ids == found_addresses_ids
  end

  test "postal code validations with invalid postal code" do
    city = insert(:city)
    {:ok, _country} =
      Countries.update_country(Repo, city.state.country, %{
        postal_code_rule: "/\d{4}+-\d{4}+/"
      })
    params = params_with_assocs(:address, %{postal_code: "pepeHands", city: city})

    assert {:error, changeset} = Addresses.create_address(Repo, params)
  end

  test "getting postal code rule from config" do
    assert Address.default_postal_code_rule() == Address.get_postal_code_rule([])
    assert 123 == Address.get_postal_code_rule(postal_code_rule: 123)
  end
end
