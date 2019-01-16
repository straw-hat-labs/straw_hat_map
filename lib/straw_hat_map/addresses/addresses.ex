defmodule StrawHat.Map.Addresses do
  @moduledoc """
  Defines functionality for addresses management.
  """

  import Ecto.Query, only: [from: 2]
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.{Address, Cities}

  @doc """
  Returns a list of addresses.
  """
  @spec get_addresses(Ecto.Repo.t(), Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_addresses(repo, pagination \\ []) do
    repo.paginate(Address, pagination)
  end

  @doc """
  Creates an address.
  """
  @spec create_address(Ecto.Repo.t(), Address.address_attrs()) ::
          Response.t(Address.t(), Ecto.Changeset.t())
  def create_address(repo, address_attrs) do
    city_id = Map.get(address_attrs, :city_id)
    postal_code_rule = Cities.get_postal_code_rule(repo, city_id)

    %Address{}
    |> Address.changeset(address_attrs, postal_code_rule: postal_code_rule)
    |> repo.insert()
    |> Response.from_value()
  end

  @doc """
  Updates an address.
  """
  @spec update_address(Ecto.Repo.t(), Address.t(), Address.address_attrs()) ::
          Response.t(Address.t(), Ecto.Changeset.t())
  def update_address(repo, %Address{} = address, address_attrs) do
    city_id = Map.get(address_attrs, :city_id, address.city_id)
    postal_code_rule = Cities.get_postal_code_rule(repo, city_id)

    address
    |> Address.changeset(address_attrs, postal_code_rule: postal_code_rule)
    |> repo.update()
    |> Response.from_value()
  end

  @doc """
  Destroys an address.
  """
  @spec destroy_address(Ecto.Repo.t(), Address.t()) :: Response.t(Address.t(), Ecto.Changeset.t())
  def destroy_address(repo, %Address{} = address) do
    address
    |> repo.delete()
    |> Response.from_value()
  end

  @doc """
  Gets an address by `id`.
  """
  @spec find_address(Ecto.Repo.t(), String.t()) :: Response.t(Address.t(), Error.t())
  def find_address(repo, address_id) do
    repo
    |> get_address(address_id)
    |> Response.from_value(
      Error.new("straw_hat_map.address.not_found", metadata: [address_id: address_id])
    )
  end

  @doc """
  Gets an address by `id`.
  """
  @spec get_address(Ecto.Repo.t(), String.t()) :: Address.t() | nil | no_return
  def get_address(repo, address_id) do
    repo.get(Address, address_id)
  end

  @doc """
  Gets list of addresses.
  """
  @spec get_addresses_by_ids(Ecto.Repo.t(), [integer()]) :: [Address.t()] | no_return()
  def get_addresses_by_ids(repo, address_ids) do
    query = from(address in Address, where: address.id in ^address_ids)
    repo.all(query)
  end
end
