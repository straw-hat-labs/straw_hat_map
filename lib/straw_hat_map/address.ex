defmodule StrawHat.Map.Address do
  @moduledoc """
  Defines functionality for addresses management.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.AddressQuery
  alias StrawHat.Map.Schema.Address

  @doc """
  Get the list of addresses.
  """
  @spec get_addresses(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_addresses(pagination \\ []), do: Repo.paginate(Address, pagination)

  @doc """
  Create an address.
  """
  @spec create_address(Address.address_attrs()) ::
          {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def create_address(address_attrs) do
    %Address{}
    |> Address.changeset(address_attrs)
    |> Repo.insert()
  end

  @doc """
  Update an address.
  """
  @spec update_address(Address.t(), Address.address_attrs()) ::
          {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def update_address(%Address{} = address, address_attrs) do
    address
    |> Address.changeset(address_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy an address.
  """
  @spec destroy_address(Address.t()) :: {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def destroy_address(%Address{} = address), do: Repo.delete(address)

  @doc """
  Get an address by `id`.
  """
  @spec find_address(String.t()) :: {:ok, Address.t()} | {:error, Error.t()}
  def find_address(address_id) do
    case get_address(address_id) do
      nil ->
        error = Error.new("straw_hat_map.address.not_found", metadata: [address_id: address_id])
        {:error, error}

      address ->
        {:ok, address}
    end
  end

  @doc """
  Get an address by `id`.
  """
  @spec get_address(String.t()) :: Address.t() | nil | no_return
  def get_address(address_id), do: Repo.get(Address, address_id)

  @doc """
  Get list of addresses.
  """
  @spec get_addresses_by_ids([integer()]) :: [Address.t()] | no_return()
  def get_addresses_by_ids(address_ids) do
    Address
    |> AddressQuery.by_ids(address_ids)
    |> Repo.all()
  end
end
