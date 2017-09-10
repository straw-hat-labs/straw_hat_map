defmodule StrawHat.Map.Address do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.AddressQuery
  alias StrawHat.Map.Schema.Address

  def get_addresses(pagination \\ []), do: Repo.paginate(Address, pagination)

  def create_address(address_attrs) do
    %Address{}
    |> Address.changeset(address_attrs)
    |> Repo.insert()
  end

  def update_address(%Address{} = address, address_attrs) do
    address
    |> Address.changeset(address_attrs)
    |> Repo.update()
  end

  def destroy_address(%Address{} = address), do: Repo.delete(address)

  def find_address(address_id) do
    case get_address(address_id) do
      nil ->
        error = Error.new("map.address.not_found", metadata: [address_id: address_id])
        {:error, error}
      address ->  {:ok, address}
    end
  end

  def get_address(address_id), do: Repo.get(Address, address_id)

  def get_addresses_by_ids(address_ids) do
    Address
    |> AddressQuery.by_ids(address_ids)
    |> Repo.all()
  end
end
