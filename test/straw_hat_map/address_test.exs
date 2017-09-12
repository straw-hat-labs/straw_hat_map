defmodule StrawHat.Map.Test.AddressTest do
  use StrawHat.Map.Test.DataCase, async: true
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
    address_page = Address.get_addresses(%{page: 2, page_size: 5})

    assert address_page.total_entries == 10
  end

  test "create" do
    params = params_with_assocs(:address)

    assert {:ok, _address} = Address.create_address(params)
  end

  test "update by address" do
    address = insert(:address)
    {:ok, address} = Address.update_address(address, %{"line_two": "PO BOX 123"})

    assert address.line_two == "PO BOX 123"
  end

  test "delete by address" do
    address = insert(:address)

    assert {:ok, _} = Address.destroy_address(address)
  end

  test "list of addresses by ids" do
    available_addresses = insert_list(3, :address)
    ids =
      available_addresses
      |> Enum.take(2)
      |> Enum.map(fn address -> address.id end)
    addresses = Address.get_addresses_by_ids(ids)

    assert List.first(addresses).id == List.first(ids)
    assert List.last(addresses).id == List.last(ids)
  end
end
