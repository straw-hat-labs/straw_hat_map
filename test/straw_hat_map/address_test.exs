defmodule StrawHatMapTest.AddressTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.Address

  test "get by id" do
    address = insert(:address)
    assert {:ok, _address} = Address.find_address(address.id)
  end

  test "invalid id" do
    assert {:error, _reason} = Address.find_address(8745)
  end

  test "list per page" do
    insert_list(10, :address)
    address = Address.list_adresses(%{page: 2, page_size: 5})
    assert address.total_entries == 10
  end

  test "create" do
    city = insert(:city)
    params = %{line_one: "Main Street", line_two: "# 234A", postal_code: "12345", city_id: city.id}
    assert {:ok, _address} = Address.create_address(params)
  end

  test "update by entity" do
    address = insert(:address)
    {:ok, address} = Address.update_address(address, %{"line_two": "PO BOX 123"})
    assert address.line_two == "PO BOX 123"
  end

  test "update by id" do
    address = insert(:address)
    {:ok, address} = Address.update_address(address.id, %{"line_two": "PO BOX 123"})
    assert address.line_two == "PO BOX 123"
  end

  test "update by invalid id" do
    {:error, _} = Address.update_address(99999, %{})
  end

  test "delete address by id" do
    address = insert(:address)
    assert {:ok, _} = Address.destroy_address(address.id)
  end
end
