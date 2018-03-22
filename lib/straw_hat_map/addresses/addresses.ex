defmodule StrawHat.Map.Addresses do
  @moduledoc """
  Defines functionality for addresses management.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.Address

  @doc """
  Returns a list of addresses.
  """
  @spec get_addresses(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_addresses(pagination \\ []), do: Repo.paginate(Address, pagination)

  @doc """
  Creates an address.
  """
  @spec create_address(Address.address_attrs()) ::
          {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def create_address(address_attrs) do
    %Address{}
    |> Address.changeset(address_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an address.
  """
  @spec update_address(Address.t(), Address.address_attrs()) ::
          {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def update_address(%Address{} = address, address_attrs) do
    address
    |> Address.changeset(address_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys an address.
  """
  @spec destroy_address(Address.t()) :: {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def destroy_address(%Address{} = address), do: Repo.delete(address)

  @doc """
  Gets an address by `id`.
  """
  @spec find_address(String.t()) :: {:ok, Address.t()} | {:error, Error.t()}
  def find_address(address_id) do
    address_id
    |> get_address()
    |> StrawHat.Response.from_value(
      Error.new("straw_hat_map.address.not_found", metadata: [address_id: address_id])
    )
  end

  @doc """
  Gets an address by `id`.
  """
  @spec get_address(String.t()) :: Address.t() | nil | no_return
  def get_address(address_id), do: Repo.get(Address, address_id)

  @doc """
  Gets list of addresses.
  """
  @spec get_addresses_by_ids([integer()]) :: [Address.t()] | no_return()
  def get_addresses_by_ids(address_ids) do
    query = from(address in Address, where: address.id in ^address_ids)
    Repo.all(query)
  end
end
