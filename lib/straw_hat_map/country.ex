defmodule StrawHat.Map.Country do
  @moduledoc """
  Defines functionality for country management.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.{CountryQuery, StateQuery}
  alias StrawHat.Map.Schema.{Country, State}

  @doc """
  Get the list of countries.
  """
  @spec get_countries(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_countries(pagination \\ []), do: Repo.paginate(Country, pagination)

  @doc """
  Create a country.
  """
  @spec create_country(Country.country_attrs()) ::
          {:ok, Country.t()} | {:error, Ecto.Changeset.t()}
  def create_country(country_attrs) do
    %Country{}
    |> Country.changeset(country_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a country.
  """
  @spec update_country(Country.t(), Country.country_attrs()) ::
          {:ok, Country.t()} | {:error, Ecto.Changeset.t()}
  def update_country(%Country{} = country, country_attrs) do
    country
    |> Country.changeset(country_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a country.
  """
  @spec destroy_country(Country.t()) :: {:ok, Country.t()} | {:error, Ecto.Changeset.t()}
  def destroy_country(%Country{} = country), do: Repo.delete(country)

  @doc """
  Get a country by `id`.
  """
  @spec find_country(String.t()) :: {:ok, Country.t()} | {:error, Error.t()}
  def find_country(country_id) do
    case get_country(country_id) do
      nil ->
        error = Error.new("straw_hat_map.country.not_found", metadata: [country_id: country_id])
        {:error, error}

      country ->
        {:ok, country}
    end
  end

  @doc """
  Get a country by `id`.
  """
  @spec get_country(String.t()) :: Country.t() | nil | no_return
  def get_country(country_id), do: Repo.get(Country, country_id)

  @doc """
  Get list of countries.
  """
  @spec get_countries_by_ids([integer()]) :: [Country.t()] | no_return()
  def get_countries_by_ids(country_ids) do
    Country
    |> CountryQuery.by_ids(country_ids)
    |> Repo.all()
  end

  @doc """
  Get list of states.
  """
  @spec get_states([integer()]) :: [State.t()] | no_return()
  def get_states(country_ids) when is_list(country_ids) do
    State
    |> StateQuery.by_countries(country_ids)
    |> Repo.all()
  end
end
