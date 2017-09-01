defmodule StrawHat.Map.Address do
  alias StrawHat.Map.Query.Address, as: AddressQuery
  alias StrawHat.Error
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.Address

  def list_adresses(paginate), do: Repo.paginate(Address, paginate)

  def create_address(params) do
    %Address{}
    |> Address.changeset(params)
    |> Repo.insert()
  end

  def update_address(%Address{} = address, params) do
    address
    |> Address.changeset(params)
    |> Repo.update()
  end

  def destroy_address(%Address{} = address), do: Repo.delete(address)

  def find_address(id) do
    case get_address(id) do
      nil -> {:error, Error.new("map.address.not_found", metadata: [id: id])}
      address ->  {:ok, address}
    end
  end

  def get_address(id), do: Repo.get(Address, id)

  def address_by_ids(address_ids) do
    Address
    |> AddressQuery.by_ids(address_ids)
    |> Repo.all()
  end
end
