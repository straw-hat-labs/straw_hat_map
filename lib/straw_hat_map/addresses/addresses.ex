defmodule StrawHat.Map.Addresses do
  @moduledoc """
  Defines functionality for addresses management.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.Address

  @doc """
  Returns a list of addresses.
  """
  @since "1.0.0"
  @spec get_addresses(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_addresses(pagination \\ []), do: Repo.paginate(Address, pagination)

  @doc """
  Creates an address.
  """
  @since "1.0.0"
  @spec create_address(Address.address_attrs()) ::
          {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def create_address(address_attrs) do
    rule = get_postal_code_rule(address_attrs.city_id)

    %Address{}
    |> Address.changeset(address_attrs, [postal_code_rule: rule])
    |> Repo.insert()
  end

  @doc """
  Updates an address.
  """
  @since "1.0.0"
  @spec update_address(Address.t(), Address.address_attrs()) ::
          {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def update_address(%Address{} = address, address_attrs) do
    rule = get_postal_code_rule(address.city_id)

    address
    |> Address.changeset(address_attrs, [postal_code_rule: rule])
    |> Repo.update()
  end

  @doc """
  Destroys an address.
  """
  @since "1.0.0"
  @spec destroy_address(Address.t()) :: {:ok, Address.t()} | {:error, Ecto.Changeset.t()}
  def destroy_address(%Address{} = address), do: Repo.delete(address)

  @doc """
  Gets an address by `id`.
  """
  @since "1.0.0"
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
  @since "1.0.0"
  @spec get_address(String.t()) :: Address.t() | nil | no_return
  def get_address(address_id), do: Repo.get(Address, address_id)

  @doc """
  Gets list of addresses.
  """
  @since "1.0.0"
  @spec get_addresses_by_ids([integer()]) :: [Address.t()] | no_return()
  def get_addresses_by_ids(address_ids) do
    query = from(address in Address, where: address.id in ^address_ids)
    Repo.all(query)
  end

  @spec get_postal_code_rule(Integer.t()) :: Regex.t()
  defp get_postal_code_rule(city_id) do
    %StrawHat.Map.City{state: %StrawHat.Map.State{country: %StrawHat.Map.Country{postal_code_rule: rule}}} =
      StrawHat.Map.Repo.get!(City, city_id)
      |> StrawHat.Map.Repo.preload([state: :country])
    case rule do
      nil -> ~r/^\w+[ -]?\w+$/
      _ -> rule
    end
  end
end
