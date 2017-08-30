defmodule StrawHat.Map.Address do
  import Ecto.Query, only: [from: 2]

  alias StrawHat.Error
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.Address

  def list_adresses(params), do: Repo.paginate(Address, params)

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
  def update_address(id, params) do
    with {:ok, address} <- find_address(id),
      do: update_address(address, params)
  end

  def destroy_address(%Address{} = address),
    do: Repo.delete(address)
  def destroy_address(id) do
    with {:ok, address} <- find_address(id),
      do: destroy_address(address)
  end

  def find_address(id) do
    case get_address(id) do
      nil -> {:error, Error.new("map.address.not_found", metadata: [id: id])}
      address ->  {:ok, address}
    end
  end

  def get_address(id),
    do: Repo.get(Address, id)

  def address_by_ids(address_ids) do
    query =
      from a in Address,
      where: a.id in ^address_ids
    Repo.all(query)
  end
end
